import { NextRequest, NextResponse } from 'next/server';
import { prisma } from '@/lib/prisma';

export async function GET(req: NextRequest) {
  try {
    const { searchParams } = new URL(req.url);
    const search = searchParams.get('search') || '';
    const page = parseInt(searchParams.get('page') || '1');
    const limit = parseInt(searchParams.get('limit') || '20');
    const skip = (page - 1) * limit;

    const where = search ? {
      OR: [
        { nameFirmaAbholung: { contains: search, mode: 'insensitive' as const } },
        { partnernummer: { contains: search, mode: 'insensitive' as const } },
        { partnerstufe: { contains: search, mode: 'insensitive' as const } },
      ]
    } : {};

    const [total, partners] = await Promise.all([
      (prisma as any).partners.count({ where }),
      (prisma as any).partners.findMany({
        where,
        take: limit,
        skip,
        orderBy: { createdAt: 'desc' }
      })
    ]);

    // 1. Fetch related link records
    const partnerIds = (partners as any[]).map(p => p.id);
    const links = await (prisma as any).contactsPartners.findMany({
      where: {
        cuid: { in: partnerIds }
      }
    });

    // 2. Fetch actual contact records
    const contactIds = (links as any[]).map(l => l.coid).filter(Boolean);
    const contacts = await (prisma as any).contacts.findMany({
      where: {
        id: { in: contactIds }
      }
    });

    return NextResponse.json({
      partners: (partners as any[]).map((p: any) => {
        const partnerLinks = links.filter((l: any) => l.cuid === p.id);
        const firstLink = partnerLinks[0];
        const primaryContact = contacts.find((c: any) => c.id === firstLink?.coid) || null;
        
        return {
          id: p.id,
          partnernummer: p.partnernummer,
          name: p.nameFirmaAbholung || p.nameFirmaZustellung,
          partnerstufe: p.partnerstufe,
          aktiv: p.aktiv,
          ort: p.ortAbholung,
          land: p.landAbholung,
          createdAt: p.createdAt,
          contactsCount: partnerLinks.length,
          primaryContact: primaryContact
        };
      }),
      pagination: {
        total,
        page,
        limit,
        pages: Math.ceil(total / limit)
      }
    });
  } catch (error: any) {
    console.error('Error fetching partners:', error);
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
}
