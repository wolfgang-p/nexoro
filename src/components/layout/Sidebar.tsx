"use client";

import { useState } from "react";
import Link from "next/link";
import { 
  ChevronDown, 
  ChevronRight, 
  FilterX, 
  Search,
  CheckCircle2
} from "lucide-react";

interface SidebarSection {
  title: string;
  items: { label: string; count: number; active?: boolean }[];
  isOpen?: boolean;
}

export default function Sidebar() {
  const [sections, setSections] = useState<SidebarSection[]>([
    {
      title: "Diverses",
      isOpen: true,
      items: [
        { label: "Priorität", count: 3 },
        { label: "Wichtig", count: 12 },
        { label: "Neu.Lead (Web)", count: 5 }
      ]
    },
    {
      title: "Verantwortliche",
      isOpen: true,
      items: [
        { label: "agent_demo", count: 4, active: true },
        { label: "admin", count: 12 },
        { label: "support", count: 2 }
      ]
    },
    {
      title: "Partner",
      isOpen: false,
      items: [
        { label: "Google", count: 45 },
        { label: "Facebook", count: 22 }
      ]
    },
    {
      title: "Stati",
      isOpen: true,
      items: [
        { label: "Neu", count: 14 },
        { label: "In Bearbeitung", count: 28 },
        { label: "Wartend auf Kunde", count: 8 },
        { label: "Erfolgreich", count: 124 },
        { label: "Storniert", count: 3 }
      ]
    }
  ]);

  const toggleSection = (index: number) => {
    const newSections = [...sections];
    newSections[index].isOpen = !newSections[index].isOpen;
    setSections(newSections);
  };

  return (
    <aside className="w-64 bg-white border-r border-gray-200 flex flex-col h-[calc(100vh-5rem)] overflow-hidden sticky top-20 shadow-sm">
      
      {/* Header Actions */}
      <div className="p-4 border-b border-gray-100 flex items-center justify-between bg-gray-50/50">
        <span className="text-sm font-semibold text-gray-700">Filter & Status</span>
        <button 
          className="text-xs flex items-center text-gray-500 hover:text-red-500 transition-colors"
          title="Filter löschen"
        >
          <FilterX className="w-4 h-4 mr-1" />
          Clean
        </button>
      </div>

      {/* Global Sidebar Search */}
      <div className="p-3 border-b border-gray-100">
        <div className="relative">
          <Search className="w-4 h-4 absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" />
          <input 
            type="text" 
            placeholder="Suchen..." 
            className="w-full pl-9 pr-3 py-1.5 text-sm bg-gray-50 border border-gray-200 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500/20 focus:border-blue-500 transition-all font-medium text-gray-700 placeholder:font-normal"
          />
        </div>
      </div>

      {/* Scrollable Sections */}
      <div className="flex-1 overflow-y-auto custom-scrollbar p-2 space-y-1">
        {sections.map((section, idx) => (
          <div key={idx} className="mb-2">
            
            <button 
              onClick={() => toggleSection(idx)}
              className="w-full flex items-center justify-between p-2 rounded-lg hover:bg-gray-100 transition-colors group"
            >
              <span className="text-sm font-bold text-gray-800 uppercase tracking-wide">
                {section.title}
              </span>
              {section.isOpen ? (
                 <ChevronDown className="w-4 h-4 text-gray-400 group-hover:text-gray-600" />
              ) : (
                 <ChevronRight className="w-4 h-4 text-gray-400 group-hover:text-gray-600" />
              )}
            </button>

            {section.isOpen && (
              <div className="mt-1 ml-2 space-y-0.5 border-l-2 border-gray-100 pl-2">
                {section.items.map((item, itemIdx) => (
                  <Link 
                    key={itemIdx} 
                    href="#"
                    className={`flex items-center justify-between p-1.5 rounded-md text-sm transition-colors ${
                      item.active 
                        ? "bg-blue-50 text-blue-700 font-medium" 
                        : "text-gray-600 hover:bg-gray-50 hover:text-gray-900"
                    }`}
                  >
                    <div className="flex items-center truncate pr-2">
                      {item.active && <CheckCircle2 className="w-3.5 h-3.5 mr-1.5 text-blue-600" />}
                      <span className="truncate">{item.label}</span>
                    </div>
                    
                    <span className={`text-xs px-2 py-0.5 rounded-full ${
                      item.active 
                        ? "bg-blue-100 text-blue-700" 
                        : "bg-gray-100 text-gray-500"
                    }`}>
                      {item.count}
                    </span>
                  </Link>
                ))}
              </div>
            )}
            
          </div>
        ))}
      </div>
      
      {/* Footer Info Area */}
      <div className="p-4 border-t border-gray-200 bg-gray-50 text-xs text-gray-500 text-center">
        Nexoro CRM v2.0
      </div>

    </aside>
  );
}
