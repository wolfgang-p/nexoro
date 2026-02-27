import { NextRequest, NextResponse } from 'next/server';
import { prisma } from '@/lib/prisma';

export async function GET(
  req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    const { id: idStr } = await params;
    const id = parseInt(idStr);

    const partner = await (prisma as any).partners.findUnique({
      where: { id }
    });

    if (!partner) {
      return NextResponse.json({ error: 'Partner not found' }, { status: 404 });
    }

    // Manual joins to avoid out-of-sync Prisma include errors
    const contactLinks = await (prisma as any).contactsPartners.findMany({
      where: { cuid: id },
    });

    const contactIds = contactLinks.map((l: any) => l.coid).filter(Boolean);
    const contacts = await (prisma as any).contacts.findMany({
      where: { id: { in: contactIds } },
      include: { endpoints: true }
    });

    const abgabestellenLinks = await (prisma as any).partnersAbgabestellen.findMany({
      where: { partnerId: id },
      include: { abgabestelle: true }
    });

    // Attach for frontend
    const partnerWithData = {
      ...partner,
      contacts: contactLinks.map((l: any) => ({
        ...l,
        contact: contacts.find((c: any) => c.id === l.coid) || null
      })),
      abgabestellen: abgabestellenLinks
    };

    return NextResponse.json(partnerWithData);
  } catch (error: any) {
    console.error('Error fetching partner detail:', error);
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
}
