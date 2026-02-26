export const JWT_SECRET = new TextEncoder().encode(process.env.JWT_SECRET || 'fallback-secret-change-me');
export const SESSION_COOKIE_NAME = 'nexoro_session';
