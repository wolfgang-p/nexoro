import { NextRequest, NextResponse } from 'next/server';
import { prisma } from '@/lib/prisma';

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);
    const query = searchParams.get('q') || '';
    const page = parseInt(searchParams.get('page') || '1');
    const limit = parseInt(searchParams.get('limit') || '25');
    const skip = (page - 1) * limit;

    const where: any = {
      aktiv: 1,
    };

    if (query) {
      where.OR = [
        { vname: { contains: query, mode: 'insensitive' } },
        { nname: { contains: query, mode: 'insensitive' } },
        { firma: { contains: query, mode: 'insensitive' } },
        { email: { contains: query, mode: 'insensitive' } },
      ];
    }

    const [contacts, total] = await Promise.all([
      (prisma.contacts as any).findMany({
        where,
        skip,
        take: limit,
        orderBy: { id: 'desc' },
      }),
      (prisma.contacts as any).count({ where }),
    ]);

    // Fetch endpoints separately to avoid "Unknown field" errors if client is out of sync
    const contactIds = (contacts as any[]).map(c => c.id);
    const endpoints = await (prisma.endpoints as any).findMany({
      where: {
        contactId: { in: contactIds },
        endpointSubtype: 'primary',
      }
    });

    const formatted = (contacts as any[]).map(c => {
      const contactEndpoints = endpoints.filter((e: any) => e.contactId === c.id);
      const primaryEmail = contactEndpoints.find((e: any) => e.endpointType === 'email')?.endpointValue || c.email || '-';
      const primaryPhone = contactEndpoints.find((e: any) => e.endpointType === 'phone')?.endpointValue || c.nummer || '-';
      
      return {
        id: c.id,
        name: c.firma ? c.firma : `${c.vname} ${c.nname}`,
        ansprechpartner: c.firma ? `${c.vname} ${c.nname}` : '-',
        adresse: `${c.strNr || ''}, ${c.plz || ''} ${c.ort || ''}`,
        telefon: primaryPhone,
        email: primaryEmail,
        gruppe: c.gruppenId || 'Keine Gruppe',
      };
    });

    return NextResponse.json({
      contacts: formatted,
      pagination: {
        total,
        pages: Math.ceil(total / limit),
        page,
        limit,
      },
    });
  } catch (error) {
    console.error('API Error:', error);
    return NextResponse.json({ error: 'Failed to fetch contacts' }, { status: 500 });
  }
}

export async function POST(request: NextRequest) {
  try {
    const data = await request.json();
    
    const contact = await prisma.contacts.create({
      data: {
        firma: data.firma || null,
        vname: data.vorname || "-",
        nname: data.nachname || "-",
        email: data.email || null,
        nummer: data.telefon || null,
        strNr: data.strasse || null,
        plz: data.plz || null,
        ort: data.ort || null,
        land: data.land || null,
        gruppenId: data.kontaktTyp ? parseInt(data.kontaktTyp) : null,
        aktiv: 1,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
    });

    return NextResponse.json(contact);
  } catch (error) {
    console.error('API Error:', error);
    return NextResponse.json({ error: 'Failed to create contact' }, { status: 500 });
  }
}
