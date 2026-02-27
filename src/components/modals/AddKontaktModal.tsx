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
import { User, Mail, Phone, MapPin, Loader2, Save } from 'lucide-react';
// Toast removed as requested
const toast = {
  success: (msg: string) => console.log(`Success: ${msg}`),
  error: (msg: string) => console.error(`Error: ${msg}`)
};

interface AddKontaktModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
}

export function AddKontaktModal({ isOpen, onClose, onSuccess }: AddKontaktModalProps) {
  const [loading, setLoading] = useState(false);
  
  const [formData, setFormData] = useState({
    firma: '',
    vorname: '',
    nachname: '',
    email: '',
    telefon: '',
    strasse: '',
    plz: '',
    ort: '',
    land: 'Österreich',
    kontaktTyp: ''
  });

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    try {
      const resp = await fetch('/api/kontakte', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(formData),
      });

      if (resp.ok) {
        toast.success('Kontakt erfolgreich angelegt');
        onSuccess();
        onClose();
      } else {
        toast.error('Fehler beim Anlegen des Kontakts');
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
      <DialogContent className="sm:max-w-[550px]">
        <DialogHeader>
          <DialogTitle className="flex items-center gap-2 text-2xl font-bold">
            <User className="text-blue-600" />
            Neuen Kontakt anlegen
          </DialogTitle>
        </DialogHeader>

        <form onSubmit={handleSubmit} className="space-y-6 py-4">
          <div className="space-y-4">
            <div className="space-y-2">
              <Label htmlFor="c-firma">Firma (Optional)</Label>
              <Input id="c-firma" value={formData.firma} onChange={e => updateField('firma', e.target.value)} />
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label htmlFor="c-vorname">Vorname</Label>
                <Input id="c-vorname" value={formData.vorname} onChange={e => updateField('vorname', e.target.value)} required />
              </div>
              <div className="space-y-2">
                <Label htmlFor="c-nachname">Nachname</Label>
                <Input id="c-nachname" value={formData.nachname} onChange={e => updateField('nachname', e.target.value)} required />
              </div>
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-2">
                <Label htmlFor="c-email" className="flex items-center gap-2">
                  <Mail size={14} className="text-blue-500" /> E-Mail
                </Label>
                <Input id="c-email" type="email" value={formData.email} onChange={e => updateField('email', e.target.value)} required />
              </div>
              <div className="space-y-2">
                <Label htmlFor="c-telefon" className="flex items-center gap-2">
                  <Phone size={14} className="text-blue-500" /> Telefon
                </Label>
                <Input id="c-telefon" value={formData.telefon} onChange={e => updateField('telefon', e.target.value)} required />
              </div>
            </div>

            <div className="space-y-2">
              <Label htmlFor="c-strasse" className="flex items-center gap-2">
                <MapPin size={14} className="text-blue-500" /> Adresse
              </Label>
              <Input id="c-strasse" value={formData.strasse} onChange={e => updateField('strasse', e.target.value)} placeholder="Straße / Nr." />
            </div>

            <div className="grid grid-cols-3 gap-4">
              <div className="space-y-2">
                <Label htmlFor="c-plz">PLZ</Label>
                <Input id="c-plz" value={formData.plz} onChange={e => updateField('plz', e.target.value)} />
              </div>
              <div className="col-span-2 space-y-2">
                <Label htmlFor="c-ort">Ort</Label>
                <Input id="c-ort" value={formData.ort} onChange={e => updateField('ort', e.target.value)} />
              </div>
            </div>
          </div>

          <DialogFooter className="pt-6 border-t border-slate-100">
            <Button type="button" variant="ghost" onClick={onClose} disabled={loading}>Abbrechen</Button>
            <Button type="submit" className="bg-blue-600 hover:bg-blue-700 min-w-[120px]" disabled={loading}>
              {loading ? <Loader2 className="animate-spin mr-2" size={16} /> : <Save className="mr-2" size={16} />}
              Kontakt speichern
            </Button>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  );
}
