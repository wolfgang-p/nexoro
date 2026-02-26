import { cookies } from 'next/headers';
import { jwtVerify } from 'jose';
import { JWT_SECRET, SESSION_COOKIE_NAME } from './auth-constants';

export async function getSession() {
  const cookieStore = await cookies();
  const sessionToken = cookieStore.get(SESSION_COOKIE_NAME)?.value;

  if (!sessionToken) return null;

  try {
    const { payload } = await jwtVerify(sessionToken, JWT_SECRET);
    return {
      id: payload.id as number,
      username: payload.username as string
    };
  } catch (error) {
    return null;
  }
}
