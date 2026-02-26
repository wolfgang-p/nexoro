'use client';

import React, { useEffect, useState } from 'react';
import { UserPlus, Globe } from 'lucide-react';

interface Lead {
  id: number;
  auftragsnummer: string;
  createdAt: string;
  webseite: string;
  who: string;
}

export const LeadsList: React.FC = () => {
  const [leads, setLeads] = useState<Lead[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch('/api/dashboard/leads')
      .then(res => res.json())
      .then(d => {
        setLeads(Array.isArray(d) ? d : []);
        setLoading(false);
      })
      .catch(() => setLoading(false));
  }, []);

  if (loading) return <div className="space-y-4">{[1,2,3].map(i => <div key={i} className="h-14 bg-slate-50 animate-pulse rounded-lg" />)}</div>;

  return (
    <div className="space-y-4">
      {leads.map((lead) => (
        <div key={lead.id} className="relative pl-6 border-l-2 border-slate-100 pb-1 last:pb-0">
          <div className="absolute -left-[9px] top-1 h-4 w-4 rounded-full bg-white border-2 border-blue-500 flex items-center justify-center">
            <div className="h-1.5 w-1.5 rounded-full bg-blue-500" />
          </div>
          <div className="flex justify-between items-start">
            <div className="min-w-0">
              <h4 className="text-sm font-bold text-slate-800 truncate">#{lead.auftragsnummer} • {lead.who}</h4>
              <div className="flex items-center gap-2 mt-0.5 text-[11px] text-slate-400">
                <span className="flex items-center gap-1 font-medium text-slate-500">
                  <UserPlus size={12} />
                  {new Date(lead.createdAt).toLocaleDateString('de-DE')}
                </span>
                {lead.webseite && (
                  <span className="flex items-center gap-1">
                    <Globe size={11} />
                    {lead.webseite}
                  </span>
                )}
              </div>
            </div>
          </div>
        </div>
      ))}
    </div>
  );
};
