import { NextResponse } from 'next/server';
import { prisma } from '@/lib/prisma';

export async function GET() {
  try {
    // Fetch latest 10 orders (Leads) using raw SQL for the join
    const leads: any[] = await prisma.$queryRaw`
      SELECT 
        o.id,
        o.auftragsnummer,
        o.created_at as "createdAt",
        o.webseite,
        c.firma,
        c.vname,
        c.nname
      FROM orders o
      LEFT JOIN customers c ON o.customer_id = c.id
      WHERE o.aktiv = 1
      ORDER BY o.created_at DESC
      LIMIT 10
    `;

    const formattedLeads = leads.map(o => {
      const name = [o.vname, o.nname].filter(Boolean).join(' ');
      const who = o.firma ? `${o.firma}${name ? ' — ' + name : ''}` : name;

      return {
        id: o.id,
        auftragsnummer: o.auftragsnummer ? String(o.auftragsnummer) : String(o.id),
        createdAt: o.createdAt,
        webseite: o.webseite,
        who: who || 'Unbekannt'
      };
    });

    return NextResponse.json(formattedLeads);
  } catch (error) {
    console.error('Dashboard Leads Error:', error);
    return NextResponse.json({ error: 'Failed to fetch dashboard leads' }, { status: 500 });
  }
}
