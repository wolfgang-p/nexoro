import { NextResponse } from 'next/server';
import { Pool } from 'pg';
import { PrismaPg } from '@prisma/adapter-pg';
import { PrismaClient } from '@prisma/client';
import { SignJWT } from 'jose';
import { JWT_SECRET, SESSION_COOKIE_NAME } from '@/lib/auth-constants';

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

    // Securely sign the JWT using jose
    const token = await new SignJWT({ 
      id: user.id, 
      username: user.username
    })
      .setProtectedHeader({ alg: 'HS256' })
      .setIssuedAt()
      .setExpirationTime('24h')
      .sign(JWT_SECRET);
    
    const response = NextResponse.json(
      { success: true, user: { id: user.id, username: user.username } },
      { status: 200 }
    );
    
    // Set HTTPOnly cookie with standard configuration
    response.cookies.set({
      name: SESSION_COOKIE_NAME,
      value: token,
      httpOnly: true,
      secure: process.env.NODE_ENV === 'production',
      sameSite: 'lax',
      path: '/',
      maxAge: 60 * 60 * 24 // 24 hours
    });

    return response;
  } catch (error) {
    console.error("Login Error:", error);
    return NextResponse.json(
      { message: "Interner Serverfehler" },
      { status: 500 }
    );
  }
}
