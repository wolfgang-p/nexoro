"use client";

import React, { useState, useEffect } from 'react';
import { 
  Table, 
  TableBody, 
  TableCell, 
  TableHead, 
  TableHeader, 
  TableRow 
} from "@/components/ui/table";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { 
  Search, 
  Phone, 
  Mail, 
  MapPin, 
  User,
  ChevronLeft,
  ChevronRight,
  Loader2,
  ExternalLink
} from 'lucide-react';
import Link from 'next/link';
import { Badge } from "@/components/ui/badge";

interface Kontakt {
  id: number;
  name: string;
  ansprechpartner: string;
  adresse: string;
  telefon: string;
  email: string;
  gruppe: string | number;
}

export function KontaktTable() {
  const [contacts, setContacts] = useState<Kontakt[]>([]);
  const [loading, setLoading] = useState(true);
  const [search, setSearch] = useState('');
  const [page, setPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);

  const fetchContacts = async () => {
    setLoading(true);
    try {
      const resp = await fetch(`/api/kontakte?q=${search}&page=${page}`);
      const data = await resp.json();
      setContacts(data.contacts || []);
      setTotalPages(data.pagination?.pages || 1);
    } catch (err) {
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    const timer = setTimeout(() => {
      fetchContacts();
    }, 300);
    return () => clearTimeout(timer);
  }, [search, page]);

  return (
    <div className="bg-white rounded-xl border border-slate-200 shadow-sm overflow-hidden transition-all hover:shadow-md">
      <div className="p-4 border-b border-slate-100 bg-slate-50/50 flex items-center gap-4">
        <div className="relative flex-1 max-w-md">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 w-4 h-4" />
          <Input 
            placeholder="Suche nach Name, Firma, Email..." 
            className="pl-10 bg-white border-slate-200 focus:ring-blue-500 transition-all text-sm"
            value={search}
            onChange={(e) => { setSearch(e.target.value); setPage(1); }}
          />
        </div>
      </div>

      <div className="overflow-x-auto">
        <Table>
          <TableHeader className="bg-slate-50">
            <TableRow>
              <TableHead className="w-[80px] font-bold text-slate-700">ID</TableHead>
              <TableHead className="font-bold text-slate-700">Name / Firma</TableHead>
              <TableHead className="font-bold text-slate-700">Ansprechpartner</TableHead>
              <TableHead className="font-bold text-slate-700">Adresse</TableHead>
              <TableHead className="font-bold text-slate-700">Kommunikation</TableHead>
              <TableHead className="font-bold text-slate-700">Gruppe</TableHead>
              <TableHead className="w-[60px]"></TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {loading ? (
              <TableRow>
                <TableCell colSpan={7} className="h-64 text-center">
                  <div className="flex flex-col items-center justify-center gap-2 text-slate-400">
                    <Loader2 className="animate-spin text-blue-600" />
                    <span className="text-sm font-medium">Kontakte werden geladen...</span>
                  </div>
                </TableCell>
              </TableRow>
            ) : contacts.length === 0 ? (
              <TableRow>
                <TableCell colSpan={7} className="h-64 text-center text-slate-500">
                  <div className="flex flex-col items-center justify-center gap-2 text-slate-400">
                    <User size={40} strokeWidth={1} />
                    <p>Keine Kontakte gefunden.</p>
                  </div>
                </TableCell>
              </TableRow>
            ) : (
              contacts.map((c) => (
                <TableRow key={c.id} className="group hover:bg-blue-50/30 transition-colors">
                  <TableCell className="font-mono text-xs text-slate-400">#{c.id}</TableCell>
                  <TableCell>
                    <div className="font-semibold text-slate-900 group-hover:text-blue-700 transition-colors">
                      {c.name}
                    </div>
                  </TableCell>
                  <TableCell className="text-slate-600 text-sm">{c.ansprechpartner}</TableCell>
                  <TableCell>
                    <div className="flex items-center gap-2 text-slate-500 text-xs">
                      <MapPin size={12} className="text-slate-400 shrink-0" />
                      <span className="truncate max-w-[200px]">{c.adresse}</span>
                    </div>
                  </TableCell>
                  <TableCell>
                    <div className="flex flex-col gap-1">
                      <div className="flex items-center gap-2 text-xs text-slate-600">
                        <Phone size={12} className="text-blue-600 shrink-0" />
                        {c.telefon}
                      </div>
                      <div className="flex items-center gap-2 text-xs text-slate-600">
                        <Mail size={12} className="text-blue-600 shrink-0" />
                        {c.email}
                      </div>
                    </div>
                  </TableCell>
                  <TableCell>
                    <Badge variant="secondary" className="bg-slate-100 text-slate-600 text-[10px] font-bold uppercase tracking-wider">
                      {c.gruppe}
                    </Badge>
                  </TableCell>
                  <TableCell>
                    <Link href={`/kontakte/${c.id}`} className="p-2 text-slate-400 hover:text-blue-600 rounded-md hover:bg-white transition-all shadow-sm opacity-0 group-hover:opacity-100">
                      <ExternalLink size={16} />
                    </Link>
                  </TableCell>
                </TableRow>
              ))
            )}
          </TableBody>
        </Table>
      </div>

      <div className="p-4 border-t border-slate-100 flex items-center justify-between bg-slate-50/30">
        <p className="text-xs text-slate-500 font-medium">
          Seite <span className="text-slate-900">{page}</span> von <span className="text-slate-900">{totalPages}</span>
        </p>
        <div className="flex items-center gap-2">
          <Button 
            variant="outline" 
            size="sm" 
            disabled={page === 1}
            onClick={() => setPage(p => p - 1)}
            className="text-slate-600 border-slate-200"
          >
            <ChevronLeft size={16} className="mr-1" /> Zurück
          </Button>
          <Button 
            variant="outline" 
            size="sm" 
            disabled={page === totalPages}
            onClick={() => setPage(p => p + 1)}
            className="text-slate-600 border-slate-200"
          >
            Weiter <ChevronRight size={16} className="ml-1" />
          </Button>
        </div>
      </div>
    </div>
  );
}
