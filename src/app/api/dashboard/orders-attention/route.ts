import { NextResponse } from 'next/server';
import { prisma } from '@/lib/prisma';

export async function GET() {
  try {
    // Port of legacy dashboard_backend.php logic for overdue orders
    // Calculates which orders have been in their current status longer than allowed (stati.days/hours)
    // DEBUG: Check how many status_log entries exist in total
    const totalLogs: any[] = await prisma.$queryRaw`SELECT COUNT(*) as cnt FROM "status_log"`;
    console.log('Total status_log entries:', totalLogs[0].cnt);

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
          c."firma", c."vname", c."nname",
          o."aktiv" as order_aktiv,
          s."aktiv" as status_aktiv
      FROM (
          SELECT DISTINCT ON ("auftrag") "auftrag", "status", "datum"
          FROM "status_log"
          ORDER BY "auftrag", "datum" DESC
      ) sub
      LEFT JOIN "stati" s ON s."id" = sub."status"
      LEFT JOIN "orders" o ON o."id" = sub."auftrag"
      LEFT JOIN "customers" c ON o."customer_id" = c."id"
      ORDER BY sub."datum" DESC
      LIMIT 10
    `;

    console.log('Executing Diagnostic Attention Query...');
    const rows: any[] = await prisma.$queryRawUnsafe(sql);
    console.log(`Diagnostic Query returned ${rows.length} rows`);
    if (rows.length > 0) {
      console.log('Sample row data:', JSON.stringify(rows[0], (_, v) => typeof v === 'bigint' ? v.toString() : v));
    }

    const formatted = rows
      .filter(r => {
        // Now that we know 'null' can happen for active/overdue, we provide defaults
        const overdue = Number(r.overdue_sec) > 0;
        const orderAktiv = r.order_aktiv === null || Number(r.order_aktiv) === 1;
        
        return overdue && orderAktiv;
      })
      .map(r => {
        const overSec = Number(r.overdue_sec);
        let level = 'niedrig' as 'hoch' | 'mittel' | 'niedrig';
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
          id: Number(r.id),
          auftragsnummer: r.auftragsnummer ? String(r.auftragsnummer) : String(r.id),
          customer: who || 'Unbekannt',
          reason: `Seit ${human} überfällig (Status: ${r.status_name || 'Unbekannt'})`,
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
