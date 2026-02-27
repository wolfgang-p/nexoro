import React from 'react';
import { CustomerTable } from '@/components/customers/CustomerTable';
import { Users } from 'lucide-react';

export default function CustomersPage() {
  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-bold text-slate-900 tracking-tight">Kundenverwaltung</h1>
          <p className="text-slate-500 text-sm mt-1">Verwalten Sie Ihre Kundenstämme und Ansprechpartner.</p>
        </div>
        <button className="px-4 py-2 bg-blue-600 text-white rounded-lg text-sm font-semibold hover:bg-blue-700 transition-colors shadow-sm active:scale-95 flex items-center gap-2">
          <Users size={18} />
          Neuer Kunde
        </button>
      </div>
      
      <CustomerTable />
    </div>
  );
}
