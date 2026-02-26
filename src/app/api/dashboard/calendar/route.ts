import { NextResponse } from 'next/server';
import { prisma } from '@/lib/prisma';
import { getSession } from '@/lib/auth-helpers';

export async function GET() {
  const session = await getSession();
  if (!session) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });

  try {
    const user = await prisma.users.findUnique({
      where: { id: session.id },
      select: { kalenderIdWaescher: true }
    });

    if (!user?.kalenderIdWaescher) {
      return NextResponse.json({ src: null });
    }

    const params = new URLSearchParams({
      height: '600',
      wkst: '2', // Monday
      ctz: 'Europe/Vienna',
      showPrint: '0',
      showTitle: '0',
      showNav: '0',
      mode: 'AGENDA',
      showDate: '0',
      showTabs: '0',
      showCalendars: '0',
      showTz: '0',
      src: user.kalenderIdWaescher,
    });

    const src = `https://calendar.google.com/calendar/embed?${params.toString()}`;
    return NextResponse.json({ src });
  } catch (error) {
    console.error('Dashboard Calendar Error:', error);
    return NextResponse.json({ error: 'Failed to fetch calendar' }, { status: 500 });
  }
}
