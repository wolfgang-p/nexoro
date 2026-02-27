import { NextRequest, NextResponse } from 'next/server';
import { prisma } from '@/lib/prisma';

export async function POST(request: NextRequest) {
  try {
    const data = await request.json();
    
    // Create customer and linked contact in a transaction
    const result = await prisma.$transaction(async (tx) => {
      // 1. Create the Contact
      const contact = await tx.contacts.create({
        data: {
          firma: data.firma || null,
          vname: data.vorname || "-",
          nname: data.nachname || "-",
          anrede: data.anrede || null,
          titel: data.titel || null,
          uid: data.uid || null,
          uidInfo: data.uidInfo || null,
          strNr: data.strasse || null,
          plz: data.plz || null,
          ort: data.ort || null,
          land: data.land || null,
          email: data.email || null,
          nummer: data.telefon || null,
          mobil: data.mobil || null,
          sendMail: data.sendMail ? 1 : 0,
          sendSms: data.sendSms ? 1 : 0,
          anmerkung: data.anmerkung || null,
          firmenWebsite: data.webseite || null,
          isRechnung: data.isRechnung ? 1 : 0,
          gruppenId: data.kontaktTyp ? parseInt(data.kontaktTyp) : null,
          createdAt: new Date(),
          updatedAt: new Date(),
        },
      });

      // 2. Create the Customer
      const customer = await tx.customers.create({
        data: {
          kundennummer: `KD-${Date.now().toString().slice(-6)}`, // Temporary generation logic
          createdAt: new Date(),
          updatedAt: new Date(),
        },
      });

      // 3. Link them
      await tx.contactsCustomers.create({
        data: {
          coid: contact.id,
          cuid: customer.id,
          type: 'primary',
        },
      });

      return customer;
    });

    return NextResponse.json(result);
  } catch (error) {
    console.error('API Error:', error);
    return NextResponse.json({ error: 'Failed to create customer' }, { status: 500 });
  }
}
