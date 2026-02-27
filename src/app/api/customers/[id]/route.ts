import { NextRequest, NextResponse } from 'next/server';
import { prisma } from '@/lib/prisma';

export async function GET(
  req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    const { id: idStr } = await params;
    const id = parseInt(idStr);

    const customer = await (prisma as any).customers.findUnique({
      where: { id }
    });

    if (!customer) {
      return NextResponse.json({ error: 'Customer not found' }, { status: 404 });
    }

    // Manual joins to avoid out-of-sync Prisma include errors
    const links = await (prisma as any).contactsCustomers.findMany({
      where: { cuid: id },
    });

    const contactIds = links.map((l: any) => l.coid).filter(Boolean);
    const contacts = await (prisma as any).contacts.findMany({
      where: { id: { in: contactIds } },
      include: { endpoints: true }
    });

    // Attach contacts to customer object for the frontend
    const customerWithContacts = {
      ...customer,
      contacts: links.map((l: any) => ({
        ...l,
        contact: contacts.find((c: any) => c.id === l.coid) || null
      }))
    };

    return NextResponse.json(customerWithContacts);
  } catch (error: any) {
    console.error('Error fetching customer detail:', error);
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
}
