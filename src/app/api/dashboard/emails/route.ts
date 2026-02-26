import { NextResponse } from 'next/server';
import { prisma } from '@/lib/prisma';
import { getSession } from '@/lib/auth-helpers';

export async function GET() {
  const session = await getSession();
  if (!session) return NextResponse.json({ error: 'Unauthorized' }, { status: 401 });

  try {
    // Fetch latest emails from accounts the user has access to
    const emails: any[] = await prisma.$queryRaw`
      SELECT 
        e.id,
        e.date,
        e.unread_crm as "unreadCrm",
        e.from_mail_simple as "fromAddr",
        e.from_name as "fromName",
        e.subj,
        e.order_id as "orderId",
        e.read_from as "readFrom",
        e.read_date as "readDate"
      FROM email_imap e
      WHERE e.folder = 'INBOX'
      AND e.kontoid IN (
        SELECT konto_id FROM imap_konten_user iku WHERE iku.user_id = ${session.id}
      )
      ORDER BY e.date DESC
      LIMIT 20
    `;

    // Process for easy UI consumption
    const formattedEmails = emails.map(e => ({
      ...e,
      from: (e.fromName ? e.fromName + ' ' : '') + (e.fromAddr ? '<' + e.fromAddr + '>' : '')
    }));

    return NextResponse.json(formattedEmails);
  } catch (error) {
    console.error('Dashboard Emails Error:', error);
    return NextResponse.json({ error: 'Failed to fetch dashboard emails' }, { status: 500 });
  }
}
