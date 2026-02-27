import { NextRequest, NextResponse } from 'next/server';
import { prisma } from '@/lib/prisma';

export async function GET(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const id = parseInt(params.id);

    const customer = await prisma.customers.findUnique({
      where: { id },
      include: {
        contacts: {
          include: {
            contact: {
              include: {
                endpoints: true
              }
            }
          }
        },
        orders: {
          take: 10,
          orderBy: { createdAt: 'desc' },
        }
      }
    });

    if (!customer) {
      return NextResponse.json({ error: 'Customer not found' }, { status: 404 });
    }

    return NextResponse.json(customer);
  } catch (error: any) {
    console.error('Error fetching customer detail:', error);
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
}
