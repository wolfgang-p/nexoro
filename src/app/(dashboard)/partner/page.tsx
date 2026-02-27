"use client";

import React, { useState } from 'react';
import { PartnerTable } from '@/components/partners/PartnerTable';
import { Handshake } from 'lucide-react';
import { AddPartnerModal } from '@/components/modals/AddPartnerModal';

export default function PartnerPage() {
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [refreshKey, setRefreshKey] = useState(0);

  return (
    <div className="space-y-6">
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-slate-900 tracking-tight flex items-center gap-2">
            <Handshake className="text-blue-600" />
            Partnerverwaltung
          </h1>
          <p className="text-slate-500 text-sm">Übersicht aller aktiven und inaktiven Partnerstationen</p>
        </div>
        <button 
          onClick={() => setIsModalOpen(true)}
          className="px-4 py-2 bg-blue-600 text-white rounded-lg text-sm font-semibold hover:bg-blue-700 transition-all shadow-md active:scale-95 flex items-center gap-2"
        >
          <Handshake size={18} />
          Neuer Partner
        </button>
      </div>

      <PartnerTable key={refreshKey} />

      <AddPartnerModal 
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
