'use client';

import React, { useEffect, useState } from 'react';

export const CalendarWidget: React.FC = () => {
  const [src, setSrc] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch('/api/dashboard/calendar')
      .then(res => res.json())
      .then(d => {
        setSrc(d.src);
        setLoading(false);
      })
      .catch(() => setLoading(false));
  }, []);

  if (loading) return <div className="h-[300px] bg-slate-50 animate-pulse rounded-lg" />;

  if (!src) {
    return (
      <div className="h-[300px] flex items-center justify-center border-2 border-dashed border-slate-100 rounded-xl bg-slate-50/30 text-slate-400 text-sm p-8 text-center">
        Kein Kalender für Ihren Benutzer konfiguriert.
      </div>
    );
  }

  return (
    <div className="h-[350px] w-full bg-white rounded-lg overflow-hidden border border-slate-100">
      <iframe 
        src={src} 
        style={{ border: 0 }} 
        width="100%" 
        height="100%" 
        frameBorder="0" 
        scrolling="no"
      />
    </div>
  );
};
