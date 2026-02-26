import { NextResponse } from 'next/server';
import { prisma } from '@/lib/prisma';

export async function GET() {
  try {
    const thirtyDaysAgo = new Date();
    thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 29);
    thirtyDaysAgo.setHours(0, 0, 0, 0);

    // Fetch orders count per day for the last 30 days
    // We use a raw query because Prisma's grouped aggregation on DateTime isn't date-aware for PostgreSQL without complex transformations.
    const stats: any[] = await prisma.$queryRaw`
      SELECT DATE(created_at) as d, COUNT(id) as cnt
      FROM orders
      WHERE created_at >= ${thirtyDaysAgo}
      GROUP BY d
      ORDER BY d ASC
    `;

    // Map to a full 30-day series
    const result = [];
    for (let i = 29; i >= 0; i--) {
      const date = new Date();
      date.setDate(date.getDate() - i);
      const dateStr = date.toISOString().split('T')[0];
      
      const found = stats.find(s => {
        const sDate = new Date(s.d).toISOString().split('T')[0];
        return sDate === dateStr;
      });

      result.push({
        date: dateStr,
        count: found ? Number(found.cnt) : 0
      });
    }

    return NextResponse.json(result);
  } catch (error) {
    console.error('Dashboard Stats Error:', error);
    return NextResponse.json({ error: 'Failed to fetch dashboard stats' }, { status: 500 });
  }
}
