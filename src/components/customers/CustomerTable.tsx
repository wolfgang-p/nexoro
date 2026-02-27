'use client';

import React, { useState, useEffect } from 'react';
import { Search, ChevronLeft, ChevronRight, User, Building2, Mail, MapPin } from 'lucide-react';
import Link from 'next/link';

interface Customer {
  id: number;
  kundennummer: string;
  firma: string | null;
  vname: string | null;
  nname: string | null;
  email: string | null;
  plz: string | null;
  ort: string | null;
  createdAt: string;
  contactsCount: number;
  primaryContact: any | null;
}

export const CustomerTable: React.FC = () => {
  const [customers, setCustomers] = useState<Customer[]>([]);
  const [search, setSearch] = useState('');
  const [page, setPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [loading, setLoading] = useState(true);

  const fetchCustomers = async () => {
    setLoading(true);
    try {
      const res = await fetch(`/api/customers?search=${encodeURIComponent(search)}&page=${page}`);
      const data = await res.json();
      setCustomers(data.customers || []);
      setTotalPages(data.pagination?.pages || 1);
    } catch (error) {
      console.error('Error fetching customers:', error);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    const timer = setTimeout(() => {
      fetchCustomers();
    }, 300);
    return () => clearTimeout(timer);
  }, [search, page]);

  return (
    <div className="bg-white rounded-xl shadow-sm border border-slate-200 overflow-hidden">
      {/* Search Header */}
      <div className="p-4 border-b border-slate-100 bg-slate-50/50 flex flex-col md:flex-row md:items-center justify-between gap-4">
        <h2 className="text-lg font-semibold text-slate-800 flex items-center gap-2">
          <Building2 className="text-blue-600" size={20} />
          Kundenliste
        </h2>
        <div className="relative">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-400" size={18} />
          <input
            type="text"
            placeholder="Suchen nach Name, Firma, Kundennummer..."
            className="pl-10 pr-4 py-2 bg-white border border-slate-200 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-blue-500/20 w-full md:w-80 shadow-sm"
            value={search}
            onChange={(e) => {
              setSearch(e.target.value);
              setPage(1);
            }}
          />
        </div>
      </div>

      {/* Table Content */}
      <div className="overflow-x-auto">
        <table className="w-full text-left">
          <thead className="bg-slate-50/80 text-slate-500 text-[11px] uppercase tracking-wider font-semibold border-b border-slate-100">
            <tr>
              <th className="px-6 py-4">Kunde / Firma</th>
              <th className="px-6 py-4">Standort</th>
              <th className="px-6 py-4">Primärer Kontakt</th>
              <th className="px-6 py-4">Erstellt am</th>
              <th className="px-6 py-4 text-right">Aktionen</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-slate-50">
            {loading ? (
              [1, 2, 3, 4, 5].map((i) => (
                <tr key={i} className="animate-pulse">
                  <td colSpan={5} className="px-6 py-4 h-16 bg-white" />
                </tr>
              ))
            ) : customers.length === 0 ? (
              <tr>
                <td colSpan={5} className="px-6 py-32 text-center">
                  <div className="flex flex-col items-center gap-2">
                    <Building2 className="text-slate-200" size={48} />
                    <p className="text-slate-400 font-medium">Keine Kunden gefunden</p>
                  </div>
                </td>
              </tr>
            ) : (
              customers.map((customer) => (
                <tr key={customer.id} className="hover:bg-slate-50/50 transition-colors group">
                  <td className="px-6 py-4">
                    <div className="flex flex-col">
                      <span className="font-semibold text-slate-800 text-sm group-hover:text-blue-600 transition-colors">
                        {customer.firma || `${customer.vname} ${customer.nname}`}
                      </span>
                      <span className="text-[11px] text-slate-400 font-medium tracking-tight">
                        ID: {customer.kundennummer || `#${customer.id}`}
                      </span>
                    </div>
                  </td>
                  <td className="px-6 py-4">
                    <div className="flex items-center gap-1.5 text-xs text-slate-600">
                      <MapPin size={14} className="text-slate-400" />
                      {customer.plz} {customer.ort}
                    </div>
                  </td>
                  <td className="px-6 py-4">
                    {customer.primaryContact ? (
                      <div className="flex flex-col">
                        <span className="text-sm text-slate-700">{customer.primaryContact.vname} {customer.primaryContact.nname}</span>
                        <span className="text-[11px] text-slate-400 flex items-center gap-1">
                          <Mail size={12} />
                          {customer.primaryContact.email}
                        </span>
                      </div>
                    ) : (
                      <span className="text-[11px] text-slate-300 italic">Kein Kontakt hinterlegt</span>
                    )}
                  </td>
                  <td className="px-6 py-4">
                    <span className="text-xs text-slate-500">
                      {new Date(customer.createdAt).toLocaleDateString('de-DE')}
                    </span>
                  </td>
                  <td className="px-6 py-4 text-right">
                    <Link
                      href={`/kunden/${customer.id}`}
                      className="px-3 py-1.5 bg-white border border-slate-200 rounded-md text-xs font-medium text-slate-600 hover:bg-slate-50 hover:text-blue-600 transition-all shadow-sm active:scale-95 inline-block"
                    >
                      Details
                    </Link>
                  </td>
                </tr>
              ))
            )}
          </tbody>
        </table>
      </div>

      {/* Pagination Footer */}
      <div className="p-4 border-t border-slate-100 bg-slate-50/30 flex items-center justify-between">
        <p className="text-xs text-slate-500">
          Zeige <span className="font-semibold">{customers.length}</span> von <span className="font-semibold text-slate-800">unbekannter Anzahl</span> Kunden
        </p>
        <div className="flex items-center gap-2">
          <button
            onClick={() => setPage(p => Math.max(1, p - 1))}
            disabled={page === 1}
            className="p-1.5 rounded-lg border border-slate-200 bg-white disabled:opacity-50 hover:bg-slate-50 transition-colors lg:px-3 lg:py-1.5 lg:text-xs lg:font-medium flex items-center gap-1"
          >
            <ChevronLeft size={16} />
            <span className="hidden lg:inline">Zurück</span>
          </button>
          <div className="flex items-center gap-1 px-2">
            <span className="text-[13px] font-semibold text-blue-600">{page}</span>
            <span className="text-xs text-slate-400">/</span>
            <span className="text-[13px] font-medium text-slate-600">{totalPages}</span>
          </div>
          <button
            onClick={() => setPage(p => Math.min(totalPages, p + 1))}
            disabled={page === totalPages}
            className="p-1.5 rounded-lg border border-slate-200 bg-white disabled:opacity-50 hover:bg-slate-50 transition-colors lg:px-3 lg:py-1.5 lg:text-xs lg:font-medium flex items-center gap-1"
          >
            <span className="hidden lg:inline">Weiter</span>
            <ChevronRight size={16} />
          </button>
        </div>
      </div>
    </div>
  );
};
