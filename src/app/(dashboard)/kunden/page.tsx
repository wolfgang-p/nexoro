"use client";

import React, { useState } from 'react';
import { CustomerTable } from '@/components/customers/CustomerTable';
import { Building2 } from 'lucide-react';
import { AddKundeModal } from '@/components/modals/AddKundeModal';

export default function KundenPage() {
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [refreshKey, setRefreshKey] = useState(0);

  return (
    <div className="space-y-6">
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-slate-900 tracking-tight flex items-center gap-2">
            <Building2 className="text-blue-600" />
            Kundenverwaltung
          </h1>
          <p className="text-slate-500 text-sm">Übersicht aller Privat- und Unternehmenskunden</p>
        </div>
        <button 
          onClick={() => setIsModalOpen(true)}
          className="px-4 py-2 bg-blue-600 text-white rounded-lg text-sm font-semibold hover:bg-blue-700 transition-all shadow-md active:scale-95 flex items-center gap-2"
        >
          <Building2 size={18} />
          Neuer Kunde
        </button>
      </div>

      <CustomerTable key={refreshKey} />

      <AddKundeModal 
        isOpen={isModalOpen} 
        onClose={() => setIsModalOpen(false)} 
        onSuccess={() => {
          setIsModalOpen(false);
          setRefreshKey(prev => prev + 1);
        }}
      />
    </div>
  );
}
