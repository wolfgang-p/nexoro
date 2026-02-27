import { NextRequest, NextResponse } from 'next/server';
import { prisma } from '@/lib/prisma';

export async function POST(request: NextRequest) {
  try {
    const data = await request.json();
    
    // Create partner and linked contact in a transaction
    const result = await prisma.$transaction(async (tx) => {
      // 1. Create the Partner
      const partner = await tx.partners.create({
        data: {
          partnernummer: `PN-${Date.now().toString().slice(-6)}`,
          partnerstufe: data.partnerstufe || 'Bronze',
          partnertyp: data.partnertyp || 'Vertriebspartner',
          aktiv: 1,
          createdAt: new Date(),
          updatedAt: new Date(),
          // Add other fields as needed from data
        },
      });

      // 2. Create the Primary Contact
      const contact = await tx.contacts.create({
        data: {
          firma: data.firma || null,
          vname: data.vorname || "-",
          nname: data.nachname || "-",
          email: data.email || null,
          nummer: data.telefon || null,
          aktiv: 1,
          createdAt: new Date(),
          updatedAt: new Date(),
        },
      });

      // 3. Link them
      await tx.contactsPartners.create({
        data: {
          coid: contact.id,
          cuid: partner.id,
          type: 'primary',
        },
      });

      return partner;
    });

    return NextResponse.json(result);
  } catch (error) {
    console.error('API Error:', error);
    return NextResponse.json({ error: 'Failed to create partner' }, { status: 500 });
  }
}
