import { NextResponse } from 'next/server';
import { prisma } from '@/lib/prisma';

export async function GET() {
  try {
    // Port of legacy dashboard_backend.php logic for overdue orders
    // Calculates which orders have been in their current status longer than allowed (stati.days/hours)
    const sql = `
      SELECT 
          sub."auftrag" AS id,
          o."auftragsnummer",
          s."Name" AS status_name,
          COALESCE(s."days", 0) AS days_allowed,
          COALESCE(s."hours", 0) AS hours_allowed,
          sub."datum" AS status_since,
          EXTRACT(EPOCH FROM (NOW() - sub."datum")) AS elapsed_sec,
          (COALESCE(s."days", 0) * 86400 + COALESCE(s."hours", 0) * 3600) AS allowed_sec,
          (EXTRACT(EPOCH FROM (NOW() - sub."datum")) - (COALESCE(s."days", 0) * 86400 + COALESCE(s."hours", 0) * 3600)) AS overdue_sec,
          c."firma", c."vname", c."nname"
      FROM (
          SELECT DISTINCT ON ("auftrag") "auftrag", "status", "datum"
          FROM "status_log"
          ORDER BY "auftrag", "datum" DESC
      ) sub
      INNER JOIN "stati" s ON s."id" = sub."status"
      INNER JOIN "orders" o ON o."id" = sub."auftrag"
      LEFT JOIN "customers" c ON o."customer_id" = c."id"
      WHERE o."aktiv" = 1 
      AND s."aktiv" = 1
      AND (EXTRACT(EPOCH FROM (NOW() - sub."datum")) - (COALESCE(s."days", 0) * 86400 + COALESCE(s."hours", 0) * 3600)) > 0
      ORDER BY overdue_sec DESC
      LIMIT 10
    `;

    console.log('Executing Hyper-Quoted Attention Query...');
    const rows: any[] = await prisma.$queryRawUnsafe(sql);
    console.log(`Attention Query returned ${rows.length} rows`);

    const formatted = rows.map(r => {
      const overSec = Number(r.overdue_sec);
      let level = 'niedrig';
      const days = Math.floor(Math.max(overSec, 0) / 86400);
      if (days >= 7) level = 'hoch';
      else if (days >= 3) level = 'mittel';

      const hours = Math.floor(Math.max(overSec - days * 86400, 0) / 3600);
      const mins = Math.floor(Math.max(overSec - days * 86400 - hours * 3600, 0) / 60);
      
      const human = [
        days > 0 ? `${days} Tag${days === 1 ? '' : 'e'}` : '',
        hours > 0 ? `${hours} Std.` : '',
        (days === 0 && hours === 0) ? `${mins} Min.` : ''
      ].filter(Boolean).join(' ');

      const name = [r.vname, r.nname].filter(Boolean).join(' ');
      const who = r.firma ? `${r.firma}${name ? ' — ' + name : ''}` : name;

      return {
        id: r.id,
        auftragsnummer: r.auftragsnummer ? String(r.auftragsnummer) : String(r.id),
        customer: who || 'Unbekannt',
        reason: `Seit ${human || 'wenigen Minuten'} überfällig (Status: ${r.status_name || ''})`,
        level
      };
    });

    return NextResponse.json(formatted);
  } catch (error: any) {
    console.error('Dashboard Attention Orders Error:', error);
    return NextResponse.json({ 
      error: 'Failed to fetch overdue orders',
      message: error.message,
      sql_error_code: error.code
    }, { status: 500 });
  }
}
