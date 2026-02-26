import { NextResponse } from 'next/server';
import { SESSION_COOKIE_NAME } from '@/lib/auth-constants';

export async function POST() {
  const response = NextResponse.json(
    { success: true, message: 'Logout erfolgreich' },
    { status: 200 }
  );

  response.cookies.set({
    name: SESSION_COOKIE_NAME,
    value: '',
    httpOnly: true,
    expires: new Date(0),
    path: '/',
  });

  return response;
}
