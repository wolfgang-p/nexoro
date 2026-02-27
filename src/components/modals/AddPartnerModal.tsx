"use client";

import React, { useState } from 'react';
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogFooter,
} from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { 
  Select, 
  SelectContent, 
  SelectItem, 
  SelectTrigger, 
  SelectValue 
} from "@/components/ui/select";
import { Building2, User, Mail, Phone, Handshake, ShieldCheck, Loader2 } from 'lucide-react';
// Toast removed as requested
const toast = {
  success: (msg: string) => console.log(`Success: ${msg}`),
  error: (msg: string) => console.error(`Error: ${msg}`)
};

interface AddPartnerModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
}

export function AddPartnerModal({ isOpen, onClose, onSuccess }: AddPartnerModalProps) {
  const [loading, setLoading] = useState(false);
  
  const [formData, setFormData] = useState({
    firma: '',
    vorname: '',
    nachname: '',
    email: '',
    telefon: '',
    partnerstufe: 'Bronze',
    partnertyp: 'Vertriebspartner',
  });

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    try {
      const resp = await fetch('/api/partner', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(formData),
      });

      if (resp.ok) {
        toast.success('Partner erfolgreich angelegt');
        onSuccess();
        onClose();
      } else {
        const errData = await resp.json();
        toast.error(errData.error || 'Fehler beim Anlegen des Partners');
      }
    } catch (err) {
      console.error(err);
      toast.error('Ein unerwarteter Fehler ist aufgetreten');
    } finally {
      setLoading(false);
    }
  };

  const updateField = (field: string, value: any) => {
    setFormData(prev => ({ ...prev, [field]: value }));
  };

  return (
    <Dialog open={isOpen} onOpenChange={onClose}>
      <DialogContent className="sm:max-w-[600px]">
        <DialogHeader>
          <DialogTitle className="flex items-center gap-2 text-2xl font-bold">
            <Handshake className="text-blue-600" />
            Neuen Partner anlegen
          </DialogTitle>
        </DialogHeader>

        <form onSubmit={handleSubmit} className="space-y-6 py-4">
          <div className="grid grid-cols-2 gap-4">
            <div className="space-y-2 col-span-2">
              <Label htmlFor="p-firma" className="flex items-center gap-2">
                <Building2 size={14} className="text-blue-500" /> Firmenname / Partnername
              </Label>
              <Input 
                id="p-firma" 
                value={formData.firma} 
                onChange={e => updateField('firma', e.target.value)} 
                required
                className="focus:ring-blue-500"
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="p-vorname">Ansprechpartner Vorname</Label>
              <Input 
                id="p-vorname" 
                value={formData.vorname} 
                onChange={e => updateField('vorname', e.target.value)} 
                required 
              />
            </div>
            <div className="space-y-2">
              <Label htmlFor="p-nachname">Ansprechpartner Nachname</Label>
              <Input 
                id="p-nachname" 
                value={formData.nachname} 
                onChange={e => updateField('nachname', e.target.value)} 
                required 
              />
            </div>

            <div className="space-y-2">
              <Label htmlFor="p-email" className="flex items-center gap-2">
                <Mail size={14} className="text-blue-500" /> E-Mail
              </Label>
              <Input 
                id="p-email" 
                type="email" 
                value={formData.email} 
                onChange={e => updateField('email', e.target.value)} 
                required 
              />
            </div>
            <div className="space-y-2">
              <Label htmlFor="p-telefon" className="flex items-center gap-2">
                <Phone size={14} className="text-blue-500" /> Telefon
              </Label>
              <Input 
                id="p-telefon" 
                value={formData.telefon} 
                onChange={e => updateField('telefon', e.target.value)} 
              />
            </div>

            <div className="space-y-2">
              <Label className="flex items-center gap-2">
                <ShieldCheck size={14} className="text-blue-500" /> Partnerstufe
              </Label>
              <Select defaultValue="Bronze" onValueChange={v => updateField('partnerstufe', v)}>
                <SelectTrigger>
                  <SelectValue />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="Bronze">Bronze</SelectItem>
                  <SelectItem value="Silber">Silber</SelectItem>
                  <SelectItem value="Gold">Gold</SelectItem>
                  <SelectItem value="Platin">Platin</SelectItem>
                </SelectContent>
              </Select>
            </div>
            <div className="space-y-2">
              <Label>Partnertyp</Label>
              <Select defaultValue="Vertriebspartner" onValueChange={v => updateField('partnertyp', v)}>
                <SelectTrigger>
                  <SelectValue />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="Vertriebspartner">Vertriebspartner</SelectItem>
                  <SelectItem value="Annahmestelle">Annahmestelle</SelectItem>
                  <SelectItem value="Servicepartner">Servicepartner</SelectItem>
                </SelectContent>
              </Select>
            </div>
          </div>

          <DialogFooter className="pt-6 border-t border-slate-100">
            <Button type="button" variant="ghost" onClick={onClose} disabled={loading}>Abbrechen</Button>
            <Button type="submit" className="bg-blue-600 hover:bg-blue-700 min-w-[120px]" disabled={loading}>
              {loading ? <Loader2 className="animate-spin mr-2" size={16} /> : <Handshake className="mr-2" size={16} />}
              Partner anlegen
            </Button>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  );
}
