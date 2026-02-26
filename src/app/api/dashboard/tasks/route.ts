import { NextResponse } from 'next/server';
import { prisma } from '@/lib/prisma';
import { Prisma } from '@prisma/client';
import { getSession } from '@/lib/auth-helpers';

export async function GET() {
  const session = await getSession();
  if (!session) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });

  try {
    // 1. Get user's groups
    const userGroups: any[] = await prisma.$queryRaw`
      SELECT aufgabengruppen_id FROM aufgabengruppen_user WHERE user_id = ${session.id}
    `;
    const groupIds = userGroups.map(ug => ug.aufgabengruppen_id).filter(id => id !== null);

    // 2. Fetch tasks assigned to user or their groups
    // If no groups, we just check for the user
    const tasks: any[] = await prisma.$queryRaw`
      SELECT 
        a.id, a.order_id as "orderId", a.auftragsnummer, a.kundennummer, a.kundenname, 
        a.was, a.gruppe, a."user", a.wann, a.created_at as "createdAt",
        ag.name as "groupName"
      FROM aufgaben a
      LEFT JOIN aufgabengruppen ag ON a.gruppe = ag.id
      WHERE a.aktiv = 1 
      AND (
        a."user" = ${session.username} 
        ${groupIds.length > 0 ? Prisma.sql`OR a.gruppe IN (${Prisma.join(groupIds)})` : Prisma.sql``}
      )
      ORDER BY (a.wann IS NULL) ASC, a.wann ASC, a.created_at DESC
      LIMIT 10
    `;

    return NextResponse.json(tasks.map(t => ({
      ...t,
      // Handle potential assignment type for UI
      assigned: t.user === session.username ? 'user' : 'group'
    })));
  } catch (error) {
    console.error('Dashboard Tasks Error:', error);
    return NextResponse.json({ error: 'Failed to fetch dashboard tasks' }, { status: 500 });
  }
}
