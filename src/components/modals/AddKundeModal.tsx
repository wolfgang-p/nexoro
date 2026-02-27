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
import { Checkbox } from "@/components/ui/checkbox";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Building2, User, MapPin, Mail, Phone, Globe, CreditCard, Loader2 } from 'lucide-react';
// Toast removed as requested
const toast = {
  success: (msg: string) => console.log(`Success: ${msg}`),
  error: (msg: string) => console.error(`Error: ${msg}`)
};

interface AddKundeModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
}

export function AddKundeModal({ isOpen, onClose, onSuccess }: AddKundeModalProps) {
  const [loading, setLoading] = useState(false);
  const [isUnternehmen, setIsUnternehmen] = useState(false);
  
  const [formData, setFormData] = useState({
    firma: '',
    vorname: '',
    nachname: '',
    anrede: '',
    titel: '',
    uid: '',
    uidInfo: '',
    strasse: '',
    plz: '',
    ort: '',
    land: 'Österreich',
    email: '',
    telefon: '',
    mobil: '',
    sendMail: true,
    sendSms: false,
    webseite: '',
    anmerkung: '',
    kontaktTyp: '',
    isRechnung: false
  });

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    try {
      const resp = await fetch('/api/kunden', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(formData),
      });

      if (resp.ok) {
        toast.success('Kunde erfolgreich angelegt');
        onSuccess();
        onClose();
      } else {
        toast.error('Fehler beim Anlegen des Kunden');
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
      <DialogContent className="sm:max-w-[700px] max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle className="flex items-center gap-2 text-2xl font-bold">
            <Building2 className="text-blue-600" />
            Neuen Kunden anlegen
          </DialogTitle>
        </DialogHeader>

        <form onSubmit={handleSubmit} className="space-y-6 py-4">
          <div className="flex items-center gap-6 p-4 bg-slate-50 rounded-xl border border-slate-100">
            <div className="flex items-center gap-2">
              <Checkbox 
                id="type-privat" 
                checked={!isUnternehmen} 
                onCheckedChange={() => setIsUnternehmen(false)} 
              />
              <Label htmlFor="type-privat" className="cursor-pointer">Privatperson</Label>
            </div>
            <div className="flex items-center gap-2">
              <Checkbox 
                id="type-firma" 
                checked={isUnternehmen} 
                onCheckedChange={() => setIsUnternehmen(true)} 
              />
              <Label htmlFor="type-firma" className="cursor-pointer">Unternehmen</Label>
            </div>
          </div>

          <Tabs defaultValue="basis" className="w-full">
            <TabsList className="grid w-full grid-cols-3 bg-slate-100/50 p-1">
              <TabsTrigger value="basis" className="data-[state=active]:bg-white data-[state=active]:shadow-sm">Basisdaten</TabsTrigger>
              <TabsTrigger value="adresse" className="data-[state=active]:bg-white data-[state=active]:shadow-sm">Adresse</TabsTrigger>
              <TabsTrigger value="kontakt" className="data-[state=active]:bg-white data-[state=active]:shadow-sm">Kommunikation</TabsTrigger>
            </TabsList>

            <TabsContent value="basis" className="space-y-4 pt-4">
              {isUnternehmen && (
                <div className="space-y-2">
                  <Label htmlFor="firma">Firmenname</Label>
                  <Input 
                    id="firma" 
                    value={formData.firma} 
                    onChange={e => updateField('firma', e.target.value)} 
                    placeholder="GmbH / KG"
                    className="focus:ring-blue-500"
                  />
                </div>
              )}

              <div className="grid grid-cols-2 gap-4">
                <div className="space-y-2">
                  <Label>Anrede</Label>
                  <Select onValueChange={(v: string) => updateField('anrede', v)}>
                    <SelectTrigger>
                      <SelectValue placeholder="Wählen..." />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value="Herr">Herr</SelectItem>
                      <SelectItem value="Frau">Frau</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
                <div className="space-y-2">
                  <Label htmlFor="titel">Titel</Label>
                  <Input id="titel" value={formData.titel} onChange={e => updateField('titel', e.target.value)} placeholder="Dr. / Mag." />
                </div>
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div className="space-y-2">
                  <Label htmlFor="vorname">Vorname</Label>
                  <Input id="vorname" value={formData.vorname} onChange={e => updateField('vorname', e.target.value)} required />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="nachname">Nachname</Label>
                  <Input id="nachname" value={formData.nachname} onChange={e => updateField('nachname', e.target.value)} required />
                </div>
              </div>

              {isUnternehmen && (
                <div className="grid grid-cols-2 gap-4">
                  <div className="space-y-2">
                    <Label htmlFor="uid">UID-Nummer</Label>
                    <Input id="uid" value={formData.uid} onChange={e => updateField('uid', e.target.value)} placeholder="ATU12345678" />
                  </div>
                  <div className="space-y-2">
                    <Label>UID-Status</Label>
                    <Select onValueChange={(v: string) => updateField('uidInfo', v)}>
                      <SelectTrigger>
                        <SelectValue placeholder="Wählen..." />
                      </SelectTrigger>
                      <SelectContent>
                        <SelectItem value="aktiv">Aktiv</SelectItem>
                        <SelectItem value="beantragt">In Beantragung</SelectItem>
                        <SelectItem value="nachreichen">Wird nachgereicht</SelectItem>
                      </SelectContent>
                    </Select>
                  </div>
                </div>
              )}
            </TabsContent>

            <TabsContent value="adresse" className="space-y-4 pt-4">
              <div className="space-y-2">
                <Label htmlFor="strasse">Straße & Hausnummer</Label>
                <div className="flex gap-2">
                  <Input id="strasse" className="flex-1" value={formData.strasse} onChange={e => updateField('strasse', e.target.value)} placeholder="Musterstraße 123" />
                </div>
              </div>
              <div className="grid grid-cols-3 gap-4">
                <div className="space-y-2">
                  <Label htmlFor="plz">PLZ</Label>
                  <Input id="plz" value={formData.plz} onChange={e => updateField('plz', e.target.value)} />
                </div>
                <div className="col-span-2 space-y-2">
                  <Label htmlFor="ort">Ort</Label>
                  <Input id="ort" value={formData.ort} onChange={e => updateField('ort', e.target.value)} />
                </div>
              </div>
              <div className="space-y-2">
                <Label>Land</Label>
                <Select defaultValue="Österreich" onValueChange={(v: string) => updateField('land', v)}>
                  <SelectTrigger>
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="Österreich">Österreich</SelectItem>
                    <SelectItem value="Deutschland">Deutschland</SelectItem>
                    <SelectItem value="Schweiz">Schweiz</SelectItem>
                  </SelectContent>
                </Select>
              </div>
            </TabsContent>

            <TabsContent value="kontakt" className="space-y-4 pt-4">
              <div className="space-y-2">
                <Label htmlFor="email" className="flex items-center gap-2">
                  <Mail size={14} className="text-blue-500" /> E-Mail Adresse
                </Label>
                <Input id="email" type="email" value={formData.email} onChange={e => updateField('email', e.target.value)} />
              </div>
              <div className="grid grid-cols-2 gap-4">
                <div className="space-y-2">
                  <Label htmlFor="telefon" className="flex items-center gap-2">
                    <Phone size={14} className="text-blue-500" /> Telefon
                  </Label>
                  <Input id="telefon" value={formData.telefon} onChange={e => updateField('telefon', e.target.value)} />
                </div>
                <div className="space-y-2">
                  <Label htmlFor="mobil" className="flex items-center gap-2">
                    <Phone size={14} className="text-blue-500" /> Mobil (SMS)
                  </Label>
                  <Input id="mobil" value={formData.mobil} onChange={e => updateField('mobil', e.target.value)} />
                </div>
              </div>
              <div className="space-y-2">
                <Label htmlFor="webseite" className="flex items-center gap-2">
                  <Globe size={14} className="text-blue-500" /> Webseite
                </Label>
                <Input id="webseite" value={formData.webseite} onChange={e => updateField('webseite', e.target.value)} placeholder="https://..." />
              </div>
              
              <div className="flex flex-col gap-3 p-4 bg-blue-50/50 rounded-lg border border-blue-100 mt-4">
                <div className="flex items-center gap-2">
                  <Checkbox 
                    id="sendMail" 
                    checked={formData.sendMail} 
                    onCheckedChange={(v: boolean | "indeterminate") => updateField('sendMail', !!v)} 
                  />
                  <Label htmlFor="sendMail" className="text-sm">Statusmeldungen per E-Mail erhalten</Label>
                </div>
                <div className="flex items-center gap-2">
                  <Checkbox 
                    id="sendSms" 
                    checked={formData.sendSms} 
                    onCheckedChange={(v: boolean | "indeterminate") => updateField('sendSms', !!v)} 
                  />
                  <Label htmlFor="sendSms" className="text-sm">Statusmeldungen per SMS erhalten</Label>
                </div>
              </div>
            </TabsContent>
          </Tabs>

          <DialogFooter className="pt-6 border-t border-slate-100">
            <Button type="button" variant="ghost" onClick={onClose} disabled={loading}>Abbrechen</Button>
            <Button type="submit" className="bg-blue-600 hover:bg-blue-700 min-w-[120px]" disabled={loading}>
              {loading ? <Loader2 className="animate-spin mr-2" size={16} /> : <CreditCard className="mr-2" size={16} />}
              Kunde anlegen
            </Button>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  );
}
