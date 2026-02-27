'use client';

import React, { useState, useEffect } from 'react';
import { 
  Handshake, 
  Mail, 
  MapPin, 
  Phone, 
  Calendar, 
  ShieldCheck, 
  Users, 
  Globe,
  FileText,
  CreditCard,
  MessageSquare,
  Award,
  Clock
} from 'lucide-react';
import { useParams } from 'next/navigation';
import Link from 'next/link';

export const PartnerDetailView: React.FC = () => {
  const params = useParams();
  const [partner, setPartner] = useState<any>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch(`/api/partners/${params.id}`)
      .then(res => res.json())
      .then(data => {
        setPartner(data);
        setLoading(false);
      })
      .catch(err => {
        console.error('Error fetching partner:', err);
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

  if (!partner || partner.error) return (
    <div className="text-center py-20 bg-white rounded-xl border border-slate-200 shadow-sm">
      <Handshake size={48} className="mx-auto text-slate-200 mb-4" />
      <h2 className="text-xl font-semibold text-slate-800">Partner nicht gefunden</h2>
      <p className="text-slate-500 mt-2">Der angeforderte Datensatz existiert nicht.</p>
      <Link href="/partners" className="inline-block mt-6 px-4 py-2 bg-slate-100 text-slate-700 rounded-lg hover:bg-slate-200 transition-colors font-medium">
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
            <div className="p-4 bg-purple-50 text-purple-600 rounded-2xl shadow-inner border border-purple-100/50">
              <Handshake size={32} />
            </div>
            <div>
              <div className="flex items-center gap-3">
                <h1 className="text-2xl font-bold text-slate-900 tracking-tight">{partner.nameFirmaAbholung || 'Unbenannter Partner'}</h1>
                <div className="flex items-center gap-2">
                  <span className="px-2.5 py-0.5 bg-purple-100 text-purple-700 rounded-full text-[10px] uppercase font-bold tracking-wider border border-purple-200">
                    {partner.partnerstufe || 'Standard'}
                  </span>
                  <span className={`px-2.5 py-0.5 rounded-full text-[10px] uppercase font-bold tracking-wider border ${partner.aktiv ? 'bg-green-50 text-green-600 border-green-100' : 'bg-slate-100 text-slate-400 border-slate-200'}`}>
                    {partner.aktiv ? 'Aktiv' : 'Inaktiv'}
                  </span>
                </div>
              </div>
              <div className="flex flex-wrap items-center gap-4 mt-2 text-slate-500 text-sm">
                <div className="flex items-center gap-1.5 bg-slate-50 px-2 py-0.5 rounded border border-slate-100">
                  <MapPin size={14} className="text-slate-400" />
                  {partner.ortAbholung} {partner.landAbholung && `, ${partner.landAbholung}`}
                </div>
                {partner.partnernummer && (
                  <div className="flex items-center gap-1.5">
                    <Award size={14} className="text-slate-400" />
                    <span className="font-mono text-slate-600">P-NR: {partner.partnernummer}</span>
                  </div>
                )}
                {partner.firmenWebsite && (
                  <a href={partner.firmenWebsite.startsWith('http') ? partner.firmenWebsite : `https://${partner.firmenWebsite}`} target="_blank" rel="noopener noreferrer" className="flex items-center gap-1.5 text-blue-600 hover:underline">
                    <Globe size={14} />
                    {partner.firmenWebsite}
                  </a>
                )}
              </div>
            </div>
          </div>
          <div className="flex items-center gap-3">
            <button className="px-4 py-2 text-slate-600 text-sm font-semibold hover:bg-slate-50 rounded-lg transition-colors border border-slate-200">
              Profil bearbeiten
            </button>
            <button className="px-4 py-2 bg-purple-600 text-white text-sm font-semibold hover:bg-purple-700 rounded-lg transition-all shadow-sm active:scale-95">
              Partner-Portal
            </button>
          </div>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-24 gap-6">
        {/* Left Column: Contract & Address */}
        <div className="lg:col-span-16 space-y-6">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            {/* Vertragsdaten */}
            <div className="bg-white p-5 rounded-xl border border-slate-200 shadow-sm relative overflow-hidden">
               <div className="absolute top-0 right-0 p-4 opacity-5 rotate-12">
                <FileText size={64} />
              </div>
              <div className="flex items-center gap-2 text-slate-800 font-bold mb-4 uppercase text-xs tracking-widest bg-slate-50 -mx-5 -mt-5 p-4 border-b border-slate-100 rounded-t-xl">
                <FileText size={14} className="text-purple-500" />
                Vertragsdaten
              </div>
              <div className="space-y-4">
                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <p className="text-[10px] text-slate-400 font-bold uppercase tracking-wider">Erstellt am</p>
                    <p className="text-sm font-medium text-slate-700 mt-0.5">{new Date(partner.createdAt).toLocaleDateString('de-DE')}</p>
                  </div>
                  <div>
                    <p className="text-[10px] text-slate-400 font-bold uppercase tracking-wider">Zuletzt aktualisiert</p>
                    <p className="text-sm font-medium text-slate-700 mt-0.5">{new Date(partner.updatedAt).toLocaleDateString('de-DE')}</p>
                  </div>
                  <div>
                    <p className="text-[10px] text-slate-400 font-bold uppercase tracking-wider">Unterzeichnet</p>
                    <p className="text-sm font-medium text-slate-700 mt-0.5">
                      {partner.partnervertragUnterzeichnetDate ? new Date(partner.partnervertragUnterzeichnetDate).toLocaleDateString('de-DE') : '-'}
                    </p>
                  </div>
                  <div>
                    <p className="text-[10px] text-slate-400 font-bold uppercase tracking-wider">Entgelt</p>
                    <p className="text-sm font-bold text-slate-800 mt-0.5">{partner.partnerlizenzEntgelt?.toFixed(2) || '0.00'} €</p>
                  </div>
                </div>
                <div className="p-3 bg-purple-50/50 rounded-lg border border-purple-100">
                  <p className="text-[10px] text-purple-700 font-bold uppercase tracking-wider flex items-center gap-1.5 mb-2">
                    <ShieldCheck size={12} />
                    Partner-Status
                  </p>
                  <p className="text-xs text-purple-600 font-medium">
                    Dieser Partner ist als <span className="font-bold underline uppercase">{partner.isAbgabestelle ? 'Abgabestelle' : 'Vertriebspartner'}</span> klassifiziert.
                  </p>
                </div>
              </div>
            </div>

            {/* Standorte */}
            <div className="bg-white p-5 rounded-xl border border-slate-200 shadow-sm">
              <div className="flex items-center gap-2 text-slate-800 font-bold mb-4 uppercase text-xs tracking-widest bg-slate-50 -mx-5 -mt-5 p-4 border-b border-slate-100 rounded-t-xl">
                <MapPin size={14} className="text-orange-500" />
                Standort-Informationen
              </div>
              <div className="space-y-1 text-sm text-slate-600 leading-relaxed font-medium">
                <p className="text-slate-900 font-bold">{partner.nameFirmaAbholung}</p>
                <p>{partner.strNrAbholung}</p>
                {partner.tuerStockAbholung && <p>{partner.tuerStockAbholung}</p>}
                <p>{partner.plzAbholung} {partner.ortAbholung}</p>
                <p className="text-slate-400 mt-2 uppercase text-[10px] tracking-wider">{partner.landAbholung}</p>
              </div>
            </div>
          </div>

          {/* Partner-Aktivitäten / Logs */}
          <div className="bg-white rounded-xl border border-slate-200 shadow-sm overflow-hidden min-h-[300px]">
            <div className="flex items-center justify-between p-4 border-b border-slate-100 bg-slate-50/50">
              <h3 className="text-sm font-bold text-slate-800 uppercase tracking-widest flex items-center gap-2">
                <MapPin size={16} className="text-orange-500" />
                Zugeordnete Abgabestellen
              </h3>
            </div>
            {partner.abgabestellen?.length > 0 ? (
              <div className="p-4 grid grid-cols-1 md:grid-cols-2 gap-4">
                {partner.abgabestellen.map((as: any) => (
                  <div key={as.id} className="p-4 bg-slate-50 border border-slate-100 rounded-lg">
                    <p className="text-sm font-bold text-slate-800">{as.abgabestelle?.abgabeFirma || as.abgabestelle?.ansprechperson}</p>
                    <p className="text-xs text-slate-500 mt-1">{as.abgabestelle?.strasse}, {as.abgabestelle?.plz} {as.abgabestelle?.ort}</p>
                    <div className="mt-2 flex items-center gap-2">
                      <span className="text-[10px] bg-white px-1.5 py-0.5 rounded border border-slate-200 text-slate-400 font-bold uppercase">
                        {as.abgabestelle?.art}
                      </span>
                    </div>
                  </div>
                ))}
              </div>
            ) : (
              <div className="p-12 text-center bg-slate-50/20">
                <p className="text-slate-400 text-sm font-medium">Keine Abgabestellen zugeordnet</p>
              </div>
            )}
          </div>
        </div>

        {/* Right Column: Contacts */}
        <div className="lg:col-span-8 space-y-6">
          <div className="bg-white rounded-xl border border-slate-200 shadow-sm overflow-hidden">
            <div className="p-4 border-b border-slate-100 bg-slate-50/50">
              <h3 className="text-sm font-bold text-slate-800 uppercase tracking-widest flex items-center gap-2">
                <Users size={16} className="text-purple-500" />
                Kontaktpersonen
              </h3>
            </div>
            <div className="p-4 space-y-4">
              {partner.contacts?.length > 0 ? (
                partner.contacts.map((pc: any) => (
                  <div key={pc.id} className="p-4 bg-slate-50/50 rounded-lg border border-slate-100 group hover:border-purple-200 hover:bg-white transition-all">
                    <div className="flex justify-between items-start">
                      <div>
                        <p className="text-sm font-bold text-slate-800 group-hover:text-purple-600 transition-colors">
                          {pc.contact?.vname} {pc.contact?.nname}
                        </p>
                        <p className="text-[10px] text-slate-400 uppercase font-bold tracking-tight">
                          {pc.contact?.position || 'Ansprechpartner'}
                        </p>
                      </div>
                    </div>
                    <div className="mt-3 space-y-1.5 border-t border-slate-100 pt-3">
                      {pc.contact?.email && (
                        <div className="flex items-center gap-2 text-xs text-slate-600">
                          <Mail size={12} className="text-slate-400" />
                          {pc.contact.email}
                        </div>
                      )}
                      {pc.contact?.nummer && (
                        <div className="flex items-center gap-2 text-xs text-slate-600">
                          <Phone size={12} className="text-slate-400" />
                          {pc.contact.nummer}
                        </div>
                      )}
                       {pc.contact?.endpoints?.map((e: any) => (
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
                <p className="text-slate-400 text-xs text-center py-4 italic">Keine Kontaktpersonen hinterlegt</p>
              )}
              <button className="w-full py-2 border-2 border-dashed border-slate-200 rounded-lg text-slate-400 text-xs font-bold hover:border-purple-400 hover:text-purple-500 transition-all flex items-center justify-center gap-2 mt-2">
                Kontaktperson hinzufügen
              </button>
            </div>
          </div>

          {/* Actions / Utilities */}
          <div className="grid grid-cols-2 gap-3">
            <div className="bg-white p-4 rounded-xl border border-slate-200 shadow-sm text-center hover:shadow-md transition-shadow cursor-pointer group">
              <Mail className="mx-auto text-blue-500 mb-2 group-hover:scale-110 transition-transform" />
              <p className="text-[10px] font-bold text-slate-800 uppercase">E-Mail senden</p>
            </div>
            <div className="bg-white p-4 rounded-xl border border-slate-200 shadow-sm text-center hover:shadow-md transition-shadow cursor-pointer group">
              <CreditCard className="mx-auto text-green-500 mb-2 group-hover:scale-110 transition-transform" />
              <p className="text-[10px] font-bold text-slate-800 uppercase">Abrechnung</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};
