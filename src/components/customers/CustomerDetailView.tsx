'use client';

import React, { useState, useEffect } from 'react';
import { 
  Building2, 
  Mail, 
  MapPin, 
  Phone, 
  Calendar, 
  History, 
  Users, 
  ExternalLink,
  ChevronLeft,
  CreditCard,
  Truck,
  MessageSquare
} from 'lucide-react';
import Link from 'next/link';
import { useParams } from 'next/navigation';

export const CustomerDetailView: React.FC = () => {
  const params = useParams();
  const [customer, setCustomer] = useState<any>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch(`/api/customers/${params.id}`)
      .then(res => res.json())
      .then(data => {
        setCustomer(data);
        setLoading(false);
      })
      .catch(err => {
        console.error('Error fetching customer:', err);
        setLoading(false);
      });
  }, [params.id]);

  if (loading) return <div className="animate-pulse space-y-8 p-6 bg-white min-h-screen rounded-xl border border-slate-200">
    <div className="h-20 bg-slate-50 rounded-lg w-full" />
    <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
      <div className="lg:col-span-2 h-96 bg-slate-50 rounded-lg" />
      <div className="h-96 bg-slate-50 rounded-lg" />
    </div>
  </div>;

  if (!customer || customer.error) return (
    <div className="text-center py-20 bg-white rounded-xl border border-slate-200 shadow-sm">
      <Building2 size={48} className="mx-auto text-slate-200 mb-4" />
      <h2 className="text-xl font-semibold text-slate-800">Kunde nicht gefunden</h2>
      <p className="text-slate-500 mt-2">Der angeforderte Datensatz existiert nicht oder wurde verschoben.</p>
      <Link href="/customers" className="inline-block mt-6 px-4 py-2 bg-slate-100 text-slate-700 rounded-lg hover:bg-slate-200 transition-colors font-medium">
        Zurück zur Liste
      </Link>
    </div>
  );

  return (
    <div className="space-y-6 max-w-[1600px] mx-auto">
      {/* Header Info */}
      <div className="bg-white p-6 rounded-xl border border-slate-200 shadow-sm">
        <div className="flex flex-col md:flex-row md:items-center justify-between gap-6">
          <div className="flex items-start gap-5">
            <div className="p-4 bg-blue-50 text-blue-600 rounded-2xl shadow-inner border border-blue-100/50">
              <Building2 size={32} />
            </div>
            <div>
              <div className="flex items-center gap-3">
                <h1 className="text-2xl font-bold text-slate-900 tracking-tight">{customer.firma || `${customer.vname} ${customer.nname}`}</h1>
                <span className="px-2.5 py-0.5 bg-slate-100 text-slate-600 rounded-full text-[10px] uppercase font-bold tracking-wider border border-slate-200">
                  {customer.kundennummer || `#${customer.id}`}
                </span>
              </div>
              <div className="flex flex-wrap items-center gap-4 mt-2 text-slate-500 text-sm">
                <div className="flex items-center gap-1.5 bg-slate-50 px-2 py-0.5 rounded border border-slate-100">
                  <MapPin size={14} className="text-slate-400" />
                  {customer.plz} {customer.ort}
                </div>
                {customer.email && (
                  <div className="flex items-center gap-1.5">
                    <Mail size={14} className="text-slate-400" />
                    <span className="font-medium text-slate-600">{customer.email}</span>
                  </div>
                )}
                {customer.nummer && (
                  <div className="flex items-center gap-1.5">
                    <Phone size={14} className="text-slate-400" />
                    <span>{customer.nummer}</span>
                  </div>
                )}
              </div>
            </div>
          </div>
          <div className="flex items-center gap-3">
            <button className="px-4 py-2 text-slate-600 text-sm font-semibold hover:bg-slate-50 rounded-lg transition-colors border border-slate-200">
              Bearbeiten
            </button>
            <button className="px-4 py-2 bg-blue-600 text-white text-sm font-semibold hover:bg-blue-700 rounded-lg transition-all shadow-sm active:scale-95">
              Neuer Auftrag
            </button>
          </div>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-24 gap-6">
        {/* Left Column: Master Data */}
        <div className="lg:col-span-16 space-y-6">
          {/* Adressen */}
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            {/* Rechnungsadresse */}
            <div className="bg-white p-5 rounded-xl border border-slate-200 shadow-sm">
              <div className="flex items-center gap-2 text-slate-800 font-bold mb-4 uppercase text-xs tracking-widest bg-slate-50 -mx-5 -mt-5 p-4 border-b border-slate-100 rounded-t-xl">
                <CreditCard size={14} className="text-blue-500" />
                Rechnungsadresse
              </div>
              <div className="space-y-1 text-sm text-slate-600 leading-relaxed font-medium">
                <p className="text-slate-900 font-bold">{customer.firma || `${customer.vname} ${customer.nname}`}</p>
                <p>{customer.strNr}</p>
                {customer.tuerStock && <p>Tür/Stock: {customer.tuerStock}</p>}
                <p>{customer.plz} {customer.ort}</p>
                <p className="text-slate-400 mt-2 uppercase text-[10px] tracking-wider">{customer.land}</p>
              </div>
            </div>

            {/* Zustelladresse */}
            <div className="bg-white p-5 rounded-xl border border-slate-200 shadow-sm">
              <div className="flex items-center gap-2 text-slate-800 font-bold mb-4 uppercase text-xs tracking-widest bg-slate-50 -mx-5 -mt-5 p-4 border-b border-slate-100 rounded-t-xl">
                <Truck size={14} className="text-green-500" />
                Zustelladresse
              </div>
              <div className="space-y-1 text-sm text-slate-600 leading-relaxed font-medium">
                {customer.nameFirmaZustellung ? (
                  <>
                    <p className="text-slate-900 font-bold">{customer.nameFirmaZustellung}</p>
                    <p>{customer.ansprechpersonZustellung}</p>
                    <p>{customer.strNrZustellung}</p>
                    <p>{customer.plzZustellung} {customer.ortZustellung}</p>
                    <p className="text-slate-400 mt-2 uppercase text-[10px] tracking-wider">{customer.landZustellung}</p>
                  </>
                ) : (
                  <p className="text-slate-400 italic">Identisch mit Rechnungsadresse</p>
                )}
              </div>
            </div>
          </div>

          {/* Auftrags-Historie */}
          <div className="bg-white rounded-xl border border-slate-200 shadow-sm overflow-hidden min-h-[400px]">
            <div className="flex items-center justify-between p-4 border-b border-slate-100 bg-slate-50/50">
              <h3 className="text-sm font-bold text-slate-800 uppercase tracking-widest flex items-center gap-2">
                <History size={16} className="text-blue-500" />
                Letzte Aufträge
              </h3>
              <button className="text-[11px] font-bold text-blue-600 hover:text-blue-800 uppercase tracking-tight flex items-center gap-1 group">
                Alle sehen
                <ChevronLeft size={12} className="rotate-180 group-hover:translate-x-0.5 transition-transform" />
              </button>
            </div>
            {customer.orders?.length > 0 ? (
              <div className="overflow-x-auto">
                <table className="w-full text-left text-sm">
                  <thead className="text-slate-400 text-[10px] uppercase font-bold border-b border-slate-50 bg-slate-50/20">
                    <tr>
                      <th className="px-6 py-3">Auftrag-NR</th>
                      <th className="px-6 py-3">Webseite</th>
                      <th className="px-6 py-3">Status</th>
                      <th className="px-6 py-3">Datum</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-slate-50">
                    {customer.orders.map((order: any) => (
                      <tr key={order.id} className="hover:bg-slate-50/50 transition-colors">
                        <td className="px-6 py-4 font-bold text-slate-700">#{order.auftragsnummer}</td>
                        <td className="px-6 py-4 text-slate-500 font-medium">{order.webseite || '-'}</td>
                        <td className="px-6 py-4">
                          <span className={`px-2 py-0.5 rounded-full text-[10px] font-bold uppercase tracking-wider ${order.aktiv ? 'bg-green-50 text-green-600 border border-green-100' : 'bg-slate-100 text-slate-400 border border-slate-200'}`}>
                            {order.aktiv ? 'Aktiv' : 'Inaktiv'}
                          </span>
                        </td>
                        <td className="px-6 py-4 text-slate-400 text-xs">
                          {new Date(order.createdAt).toLocaleDateString('de-DE')}
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            ) : (
              <div className="p-12 text-center">
                <p className="text-slate-400 text-sm font-medium">Bisher keine Aufträge vorhanden</p>
              </div>
            )}
          </div>
        </div>

        {/* Right Column: Contacts & More */}
        <div className="lg:col-span-8 space-y-6">
          {/* Ansprechpartner */}
          <div className="bg-white rounded-xl border border-slate-200 shadow-sm overflow-hidden">
            <div className="p-4 border-b border-slate-100 bg-slate-50/50">
              <h3 className="text-sm font-bold text-slate-800 uppercase tracking-widest flex items-center gap-2">
                <Users size={16} className="text-purple-500" />
                Ansprechpartner
              </h3>
            </div>
            <div className="p-4 space-y-4">
              {customer.contacts?.length > 0 ? (
                customer.contacts.map((cc: any) => (
                  <div key={cc.id} className="p-4 bg-slate-50/50 rounded-lg border border-slate-100 hover:border-purple-200 hover:bg-white transition-all group">
                    <div className="flex justify-between items-start">
                      <div>
                        <p className="text-sm font-bold text-slate-800 group-hover:text-purple-600 transition-colors">
                          {cc.contact?.vname} {cc.contact?.nname}
                        </p>
                        <p className="text-[10px] text-slate-400 uppercase font-bold tracking-tight">
                          {cc.contact?.position || 'Zuständigkeit nicht definiert'}
                        </p>
                      </div>
                      <span className="px-1.5 py-0.5 bg-white border border-slate-200 rounded text-[9px] uppercase font-bold text-slate-400">
                        {cc.type || 'Kontakt'}
                      </span>
                    </div>
                    <div className="mt-3 space-y-1.5">
                      {cc.contact?.email && (
                        <div className="flex items-center gap-2 text-xs text-slate-600">
                          <Mail size={12} className="text-slate-400" />
                          {cc.contact.email}
                        </div>
                      )}
                      {cc.contact?.nummer && (
                        <div className="flex items-center gap-2 text-xs text-slate-600">
                          <Phone size={12} className="text-slate-400" />
                          {cc.contact.nummer}
                        </div>
                      )}
                      {cc.contact?.endpoints?.map((e: any) => (
                        <div key={e.id} className="flex items-center gap-2 text-xs text-slate-600">
                          <MessageSquare size={12} className="text-slate-400" />
                          <span className="text-[10px] text-slate-400 uppercase font-bold mr-1">{e.endpointType}:</span>
                          {e.endpointValue}
                        </div>
                      ))}
                    </div>
                  </div>
                ))
              ) : (
                <p className="text-slate-400 text-xs text-center py-4">Keine Ansprechpartner hinterlegt</p>
              )}
              <button className="w-full py-2 border-2 border-dashed border-slate-200 rounded-lg text-slate-400 text-xs font-bold hover:border-blue-400 hover:text-blue-500 transition-all flex items-center justify-center gap-2 mt-2">
                Kontakt hinzufügen
              </button>
            </div>
          </div>

          {/* Metadata Cards */}
          <div className="bg-slate-900 text-white p-6 rounded-xl shadow-lg relative overflow-hidden group">
            <div className="absolute top-0 right-0 p-8 opacity-10 group-hover:scale-110 transition-transform">
              <Building2 size={80} />
            </div>
            <div className="relative z-10">
              <h4 className="text-[10px] uppercase font-bold tracking-widest text-slate-400 mb-1">Stammdaten-Status</h4>
              <p className="text-xl font-bold mb-4">Vollständig verifiziert</p>
              <div className="space-y-3">
                <div className="flex items-center justify-between text-xs pb-2 border-b border-slate-800">
                  <span className="text-slate-500">UID Nummer</span>
                  <span className="font-mono">{customer.uid || 'Nicht angegeben'}</span>
                </div>
                <div className="flex items-center justify-between text-xs pb-2 border-b border-slate-800">
                  <span className="text-slate-500">Erstellt von</span>
                  <span className="font-medium">System / Import</span>
                </div>
                <div className="flex items-center justify-between text-xs pt-2">
                  <span className="text-slate-500">Letztes Update</span>
                  <span className="font-medium">{new Date(customer.updatedAt).toLocaleDateString('de-DE')}</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};
