import { NextRequest, NextResponse } from 'next/server';
import { prisma } from '@/lib/prisma';

export async function GET(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const id = parseInt(params.id);

    const partner = await prisma.partners.findUnique({
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
        abgabestellen: {
          include: {
            abgabestelle: true
          }
        }
      }
    });

    if (!partner) {
      return NextResponse.json({ error: 'Partner not found' }, { status: 404 });
    }

    return NextResponse.json(partner);
  } catch (error: any) {
    console.error('Error fetching partner detail:', error);
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
}
