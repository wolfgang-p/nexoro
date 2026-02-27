import React from 'react';
import { PartnerDetailView } from '@/components/partners/PartnerDetailView';
import { ChevronLeft } from 'lucide-react';
import Link from 'next/link';

export default function PartnerDetailPage() {
  return (
    <div className="space-y-6">
      <div className="flex items-center gap-4">
        <Link 
          href="/partners" 
          className="p-2 bg-white border border-slate-200 rounded-lg text-slate-400 hover:text-purple-600 hover:border-purple-100 transition-all shadow-sm"
        >
          <ChevronLeft size={20} />
        </Link>
        <div>
          <h1 className="text-xl font-bold text-slate-900 tracking-tight">Partner-Details</h1>
          <p className="text-slate-500 text-xs">Vollständiger Datensatz und Vertragshistorie</p>
        </div>
      </div>
      
      <PartnerDetailView />
    </div>
  );
}
