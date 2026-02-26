'use client';

import React, { useEffect, useState } from 'react';
import { Plus, Trash2, CheckCircle2, Circle } from 'lucide-react';

interface Note {
  id: string;
  text: string;
  done: boolean;
}

export const NotesWidget: React.FC = () => {
  const [notes, setNotes] = useState<Note[]>([]);
  const [inputValue, setInputValue] = useState('');

  useEffect(() => {
    const saved = localStorage.getItem('nexoro_dashboard_notes');
    if (saved) {
      try {
        setNotes(JSON.parse(saved));
      } catch (e) {
        console.error('Failed to parse notes');
      }
    }
  }, []);

  useEffect(() => {
    if (notes.length > 0 || localStorage.getItem('nexoro_dashboard_notes')) {
      localStorage.setItem('nexoro_dashboard_notes', JSON.stringify(notes));
    }
  }, [notes]);

  const addNote = (e: React.FormEvent) => {
    e.preventDefault();
    if (!inputValue.trim()) return;
    const newNote: Note = {
      id: Date.now().toString(),
      text: inputValue.trim(),
      done: false
    };
    setNotes([newNote, ...notes]);
    setInputValue('');
  };

  const toggleNote = (id: string) => {
    setNotes(notes.map(n => n.id === id ? { ...n, done: !n.done } : n));
  };

  const removeNote = (id: string) => {
    setNotes(notes.filter(n => n.id !== id));
  };

  return (
    <div className="space-y-4">
      <form onSubmit={addNote} className="flex gap-2">
        <input 
          type="text" 
          value={inputValue}
          onChange={(e) => setInputValue(e.target.value)}
          placeholder="Notiz hinzufügen..."
          className="flex-1 bg-slate-50 border border-slate-200 rounded-lg px-3 py-1.5 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500/20 transition-all"
        />
        <button 
          type="submit"
          className="bg-blue-600 text-white rounded-lg px-3 py-1.5 text-xs font-bold hover:bg-blue-700 transition-all flex items-center gap-1 shrink-0"
        >
          <Plus size={14} />
          Hinzufügen
        </button>
      </form>

      <div className="max-h-[200px] overflow-y-auto space-y-1.5 pr-1 custom-scrollbar">
        {notes.length === 0 ? (
          <div className="text-center py-6 text-slate-300 text-xs italic">
            Keine Notizen vorhanden
          </div>
        ) : (
          notes.map((note) => (
            <div key={note.id} className="group flex items-start gap-3 p-2 bg-slate-50/50 hover:bg-slate-50 rounded-lg transition-all">
              <button 
                onClick={() => toggleNote(note.id)}
                className={`mt-0.5 transition-colors ${note.done ? 'text-green-500' : 'text-slate-300 hover:text-slate-400'}`}
              >
                {note.done ? <CheckCircle2 size={16} /> : <Circle size={16} />}
              </button>
              <span className={`text-sm flex-1 break-words ${note.done ? 'text-slate-400 line-through' : 'text-slate-700 font-medium'}`}>
                {note.text}
              </span>
              <button 
                onClick={() => removeNote(note.id)}
                className="opacity-0 group-hover:opacity-100 text-slate-300 hover:text-red-500 transition-all"
              >
                <Trash2 size={14} />
              </button>
            </div>
          ))
        )}
      </div>
    </div>
  );
};
