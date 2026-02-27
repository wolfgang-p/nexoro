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
        { firma: { contains: search, mode: 'insensitive' as const } },
        { vname: { contains: search, mode: 'insensitive' as const } },
        { nname: { contains: search, mode: 'insensitive' as const } },
        { kundennummer: { contains: search, mode: 'insensitive' as const } },
      ]
    } : {};

    const [total, customers] = await Promise.all([
      (prisma as any).customers.count({ where }),
      (prisma as any).customers.findMany({
        where,
        take: limit,
        skip,
        orderBy: { createdAt: 'desc' },
      })
    ]);

    // Fetch related contacts manually
    const customerIds = (customers as any[]).map(c => c.id);
    const links = await (prisma as any).contactsCustomers.findMany({
      where: {
        cuid: { in: customerIds }
      }
    });

    const contactIds = (links as any[]).map(l => l.coid).filter(Boolean);
    const contacts = await (prisma as any).contacts.findMany({
      where: {
        id: { in: contactIds }
      }
    });

    return NextResponse.json({
      customers: (customers as any[]).map((c: any) => {
        const customerLinks = links.filter((l: any) => l.cuid === c.id);
        const firstLink = customerLinks[0];
        const primaryContact = contacts.find((ct: any) => ct.id === firstLink?.coid) || null;

        return {
          id: c.id,
          kundennummer: c.kundennummer,
          firma: c.firma,
          vname: c.vname,
          nname: c.nname,
          email: c.email,
          plz: c.plz,
          ort: c.ort,
          createdAt: c.createdAt,
          contactsCount: customerLinks.length,
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
    console.error('Error fetching customers:', error);
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
}
