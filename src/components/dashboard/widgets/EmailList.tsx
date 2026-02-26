'use client';

import React, { useEffect, useState } from 'react';
import { Mail, ExternalLink } from 'lucide-react';

interface Email {
  id: number;
  date: string;
  unreadCrm: number;
  from: string;
  subj: string;
  orderId?: number;
}

export const EmailList: React.FC = () => {
  const [emails, setEmails] = useState<Email[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch('/api/dashboard/emails')
      .then(res => res.json())
      .then(d => {
        setEmails(Array.isArray(d) ? d : []);
        setLoading(false);
      })
      .catch(() => setLoading(false));
  }, []);

  if (loading) return <div className="space-y-4">{[1,2,3].map(i => <div key={i} className="h-14 bg-slate-50 animate-pulse rounded-lg" />)}</div>;

  if (emails.length === 0) return <div className="text-center py-8 text-slate-400 text-sm">Keine neuen E-Mails</div>;

  return (
    <div className="divide-y divide-slate-100">
      {emails.map((email) => (
        <div key={email.id} className="py-3 flex items-start group hover:bg-slate-50 transition-colors rounded-lg px-2 -mx-2">
          <div className={`mt-1 h-2 w-2 rounded-full shrink-0 ${email.unreadCrm ? 'bg-blue-500' : 'bg-transparent'}`} />
          <div className="ml-3 flex-1 min-w-0">
            <div className="flex justify-between items-start">
              <span className={`text-sm truncate font-medium ${email.unreadCrm ? 'text-slate-900' : 'text-slate-600'}`}>
                {email.from}
              </span>
              <span className="text-[10px] text-slate-400 ml-2 whitespace-nowrap">
                {new Date(email.date).toLocaleDateString('de-DE', { hour: '2-digit', minute: '2-digit' })}
              </span>
            </div>
            <p className="text-xs text-slate-500 truncate mt-0.5">{email.subj}</p>
          </div>
          {email.orderId && (
            <a 
              href={`#order-${email.orderId}`} 
              className="ml-2 p-1 text-slate-300 hover:text-blue-500 transition-colors"
              title="Zum Auftrag"
            >
              <ExternalLink size={14} />
            </a>
          )}
        </div>
      ))}
    </div>
  );
};
