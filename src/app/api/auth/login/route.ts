import { NextResponse } from 'next/server';
import { Pool } from 'pg';
import { PrismaPg } from '@prisma/adapter-pg';
import { PrismaClient } from '@prisma/client';

let prisma: PrismaClient;

if (process.env.NODE_ENV === 'production') {
  const connectionString = process.env.DATABASE_URL;
  const pool = new Pool({ connectionString });
  const adapter = new PrismaPg(pool);
  prisma = new PrismaClient({ adapter });
} else {
  if (!(global as any).prisma) {
    const connectionString = process.env.DATABASE_URL;
    const pool = new Pool({ connectionString });
    const adapter = new PrismaPg(pool);
    (global as any).prisma = new PrismaClient({ adapter });
  }
  prisma = (global as any).prisma;
}

export async function POST(request: Request) {
  try {
    const body = await request.json();
    const { username, password } = body;

    if (!username || !password) {
      return NextResponse.json(
        { message: "Benutzername und Passwort werden benötigt" },
        { status: 400 }
      );
    }

    // Checking the legacy Users table directly via Prisma
    const user = await prisma.users.findFirst({
      where: {
        username: username,
      }
    });

    if (!user) {
      return NextResponse.json(
        { message: "Ungültige Zugangsdaten" },
        { status: 401 }
      );
    }

    // Direct password match here. 
    // Usually we would compare hashed passwords natively (argon2, bcrypt).
    if (user.password !== password) {
       return NextResponse.json(
         { message: "Ungültige Zugangsdaten" },
         { status: 401 }
       );
    }

    // In a real application, you would sign this JWT payload with jose/jsonwebtoken
    // For demo purposes, we encode a payload
    const sessionToken = Buffer.from(
      JSON.stringify({ id: user.id, username: user.username })
    ).toString('base64');
    
    const response = NextResponse.json(
      { success: true, user: { id: user.id, username: user.username } },
      { status: 200 }
    );
    
    // Set HTTPOnly cookie with standard configuration
    response.cookies.set({
      name: 'nexoro_session',
      value: sessionToken,
      httpOnly: true,
      path: '/',
      maxAge: 60 * 60 * 24 // 24 hours
    });

    return response;
  } catch (error) {
    console.error("Login Error:", error);
    return NextResponse.json(
      { message: "Interner Serverfehler", error: String(error) },
      { status: 500 }
    );
  }
}
