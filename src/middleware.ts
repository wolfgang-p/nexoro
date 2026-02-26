import { NextResponse, NextRequest } from 'next/server';
import { jwtVerify } from 'jose';
import { JWT_SECRET, SESSION_COOKIE_NAME } from './lib/auth-constants';

export async function middleware(request: NextRequest) {
  const { pathname } = request.nextUrl;
  const sessionToken = request.cookies.get(SESSION_COOKIE_NAME)?.value;

  // Paths that require authentication
  const isDashboardPath = pathname.startsWith('/') && pathname !== '/login' && !pathname.startsWith('/api/');
  const isLoginPage = pathname === '/login';

  if (isDashboardPath) {
    if (!sessionToken) {
      return NextResponse.redirect(new URL('/login', request.url));
    }

    try {
      // Verify token
      await jwtVerify(sessionToken, JWT_SECRET);
      return NextResponse.next();
    } catch (error) {
      // Invalid token, redirect to login and clear cookie
      const response = NextResponse.redirect(new URL('/login', request.url));
      response.cookies.delete(SESSION_COOKIE_NAME);
      return response;
    }
  }

  if (isLoginPage && sessionToken) {
    try {
      await jwtVerify(sessionToken, JWT_SECRET);
      // Valid session, user shouldn't be on the login page
      return NextResponse.redirect(new URL('/', request.url));
    } catch (error) {
      // Invalid token, let them stay on login but clear cookie
      const response = NextResponse.next();
      response.cookies.delete(SESSION_COOKIE_NAME);
      return response;
    }
  }

  return NextResponse.next();
}

// Define which routes the middleware should run on
export const config = {
  matcher: [
    /*
     * Match all request paths except for the ones starting with:
     * - api (API routes)
     * - _next/static (static files)
     * - _next/image (image optimization files)
     * - favicon.ico (favicon file)
     */
    '/((?!api|_next/static|_next/image|favicon.ico).*)',
  ],
};
