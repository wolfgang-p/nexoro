import React from 'react';
import { CustomerDetailView } from '@/components/customers/CustomerDetailView';
import { ChevronLeft } from 'lucide-react';
import Link from 'next/link';

export default function CustomerDetailPage() {
  return (
    <div className="space-y-6">
      <div className="flex items-center gap-4">
        <Link 
          href="/customers" 
          className="p-2 bg-white border border-slate-200 rounded-lg text-slate-400 hover:text-blue-600 hover:border-blue-100 transition-all shadow-sm"
        >
          <ChevronLeft size={20} />
        </Link>
        <div>
          <h1 className="text-xl font-bold text-slate-900 tracking-tight">Kunden-Details</h1>
          <p className="text-slate-500 text-xs">Vollständiger Datensatz und Historie</p>
        </div>
      </div>
      
      <CustomerDetailView />
    </div>
  );
}
