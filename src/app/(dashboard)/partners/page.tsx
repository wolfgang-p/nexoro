import React from 'react';
import { PartnerTable } from '@/components/partners/PartnerTable';
import { Handshake } from 'lucide-react';

export default function PartnersPage() {
  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-slate-900 tracking-tight">Partnerverwaltung</h1>
          <p className="text-slate-500 text-sm mt-1">Verwalten Sie Ihre Kooperationspartner und Partnerstufen.</p>
        </div>
        <button className="px-4 py-2 bg-purple-600 text-white rounded-lg text-sm font-semibold hover:bg-purple-700 transition-colors shadow-sm active:scale-95 flex items-center gap-2">
          <Handshake size={18} />
          Neuer Partner
        </button>
      </div>
      
      <PartnerTable />
    </div>
  );
}
