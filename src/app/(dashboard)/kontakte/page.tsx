"use client";

import React, { useState } from 'react';
import { KontaktTable } from '@/components/kontakte/KontaktTable';
import { Users } from 'lucide-react';
import { AddKontaktModal } from '@/components/modals/AddKontaktModal';

export default function KontaktePage() {
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [refreshKey, setRefreshKey] = useState(0);

  return (
    <div className="space-y-6">
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-slate-900 tracking-tight flex items-center gap-2">
            <Users className="text-blue-600" />
            Kontaktverwaltung
          </h1>
          <p className="text-slate-500 text-sm">Zentrales Adressbuch für alle Ansprechpartner und Firmenkontakte</p>
        </div>
        <button 
          onClick={() => setIsModalOpen(true)}
          className="px-4 py-2 bg-blue-600 text-white rounded-lg text-sm font-semibold hover:bg-blue-700 transition-all shadow-md active:scale-95 flex items-center gap-2"
        >
          <Users size={18} />
          Kontakt erstellen
        </button>
      </div>

      <KontaktTable key={refreshKey} />

      <AddKontaktModal 
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
