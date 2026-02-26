"use client";

import Image from "next/image";
import Link from "next/link";
import { useState, useRef, useEffect } from "react";

import { 
  FileText, 
  CheckSquare, 
  Mail, 
  MessageSquare, 
  PhoneCall, 
  HelpCircle,
  PhoneForwarded,
  Users,
  User,
  ChevronDown,
  Settings,
  Bell,
  UserCircle,
  LogOut,
  ChevronRight,
  Menu,
  X
} from "lucide-react";

interface MenuItem {
  title: string;
  icon: React.ReactNode;
  href?: string;
  count?: number;
  subItems?: { title: string; href: string; divider?: boolean }[];
}

export default function TopBar() {
  const [activeDropdown, setActiveDropdown] = useState<string | null>(null);
  const [activeSubMenu, setActiveSubMenu] = useState<string | null>(null);
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);
  const dropdownRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    function handleClickOutside(event: MouseEvent) {
      if (dropdownRef.current && !dropdownRef.current.contains(event.target as Node)) {
        setActiveDropdown(null);
        setActiveSubMenu(null);
      }
    }
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, []);

  const toggleDropdown = (title: string) => {
    if (activeDropdown === title) {
      setActiveDropdown(null);
      setActiveSubMenu(null);
    } else {
      setActiveDropdown(title);
      setActiveSubMenu(null);
    }
  };

  const menuItems: MenuItem[] = [
    { title: "Aufträge", icon: <FileText className="w-5 h-5 mb-0.5" />, href: "/auftraege" },
    { title: "Aufgaben", icon: <CheckSquare className="w-5 h-5 mb-0.5" />, href: "/aufgaben" },
    { 
      title: "Kommunikation", 
      icon: <Mail className="w-5 h-5 mb-0.5" />, 
      count: 0,
      subItems: [
        { title: "E-Mails", href: "/emails" },
        { title: "SMS", href: "/sms" },
        { title: "-", href: "#", divider: true },
        { title: "Eingehende Anrufe", href: "/anrufe/eingehend" },
        { title: "Ausgehende Anrufe", href: "/anrufe/ausgehend" },
        { title: "Meine eingehenden Anrufe", href: "/anrufe/meine-eingehend" },
        { title: "Meine ausgehenden Anrufe", href: "/anrufe/meine-ausgehend" },
        { title: "-", href: "#", divider: true },
        { title: "Aktive Rückrufe", href: "/rueckrufe/aktiv" },
        { title: "Archivierte Rückrufe", href: "/rueckrufe/archiv" },
      ]
    },
    { 
      title: "Anfragen", 
      icon: <HelpCircle className="w-5 h-5 mb-0.5" />, 
      count: 0,
      subItems: [
        { title: "Aktive Anfragen", href: "/anfragen/aktiv" },
        { title: "Archivierte Anfragen", href: "/anfragen/archiv" },
        { title: "Anfrage manuell erstellen", href: "/anfragen/erstellen" },
      ]
    },
    { 
      title: "Kunden", 
      icon: <Users className="w-5 h-5 mb-0.5" />, 
      subItems: [
        { title: "Kunden", href: "/kunden" },
        { title: "Kunden Archiv", href: "/kunden/archiv" },
        { title: "Kunden erstellen", href: "/kunden/erstellen" },
      ]
    },
    { 
      title: "Kontakte", 
      icon: <User className="w-5 h-5 mb-0.5" />, 
      subItems: [
        { title: "Kontakte", href: "/kontakte" },
        { title: "Kontakt hinzufügen", href: "/kontakte/hinzufuegen" },
      ]
    },
    { 
      title: "Partner", 
      icon: <Users className="w-5 h-5 mb-0.5" />, 
      subItems: [
        { title: "Partner", href: "/partner" },
        { title: "Partnerarchiv", href: "/partner/archiv" },
        { title: "Partner hinzufügen", href: "/partner/hinzufuegen" },
      ]
    },
    {
       title: "Admin",
       icon: <Settings className="w-5 h-5 mb-0.5" />,
       subItems: [
         { title: "Tools", href: "/admin/tools" },
         { title: "Edit", href: "/admin/edit" },
         { title: "Interna", href: "/admin/interna" },
         { title: "Statistiken", href: "/admin/statistiken" }
       ]
    }
  ];

  // Dummy notifications
  const notifications = [
    { title: "Neuer Auftrag zugewiesen", time: "Vor 5 Min" },
    { title: "Kunde XY hat Feedback gegeben", time: "Vor 10 Min" }
  ];

  return (
    <header className="fixed top-0 left-0 right-0 h-16 bg-white border-b border-gray-200 z-50 shadow-sm flex items-center justify-between px-4" ref={dropdownRef}>
      
      {/* Mobile Hamburger Menu Toggle */}
      <div className="md:hidden flex items-center">
        <button 
          onClick={() => setIsMobileMenuOpen(!isMobileMenuOpen)}
          className="p-2 text-gray-500 hover:bg-gray-100 rounded-md transition-colors"
        >
          {isMobileMenuOpen ? <X className="w-6 h-6" /> : <Menu className="w-6 h-6" />}
        </button>
      </div>

      {/* Logo Area */}
      <div className="flex items-center h-full sm:w-40">
        <Link href="/" className="flex items-center">
           <Image
            src="/images/logo.png"
            alt="Nexoro Logo"
            width={120}
            height={36}
            className="object-contain"
            priority
          />
        </Link>
      </div>

      {/* Main Navigation - Hidden on mobile */}
      <nav className="hidden md:flex items-center h-full flex-1 justify-center space-x-1 lg:space-x-4">
        {menuItems.map((item, index) => (
          <div key={index} className="relative h-full flex flex-col justify-center px-2 hover:bg-gray-50 transition-colors cursor-pointer group"
               onClick={() => item.subItems && toggleDropdown(item.title)}>
            
            {item.href && !item.subItems ? (
              <Link href={item.href} className="flex flex-col items-center justify-center text-slate-600 group-hover:text-blue-700">
                {item.icon}
                <span className="text-[10px] font-bold tracking-widest text-[#4b5563] group-hover:text-blue-700 uppercase">{item.title}</span>
              </Link>
            ) : (
              <div className="flex flex-col items-center justify-center text-slate-600 group-hover:text-blue-700">
                {item.icon}
                <div className="flex items-center space-x-0.5">
                  <span className="text-[10px] font-bold tracking-widest text-[#4b5563] group-hover:text-blue-700 uppercase">{item.title}</span>
                  {item.count !== undefined && (
                    <span className="text-[9px] bg-[#ef4444] text-white rounded-full px-1.5 py-0 min-w-[16px] text-center ml-1">
                      {item.count}
                    </span>
                  )}
                  {item.subItems && <ChevronDown className="w-3 h-3 text-slate-400 group-hover:text-blue-700" />}
                </div>
              </div>
            )}

            {/* Dropdown Menu */}
            {item.subItems && activeDropdown === item.title && (
              <div className="absolute top-[4.1rem] left-0 w-48 bg-white border border-gray-100 rounded-b-md shadow-lg py-1 z-50 animate-in fade-in slide-in-from-top-1">
                {item.subItems.map((sub, idx) => (
                  sub.divider ? (
                    <div key={idx} className="h-px bg-gray-100 my-1 mx-2"></div>
                  ) : (
                    <Link 
                      key={idx} 
                      href={sub.href}
                      className="block px-4 py-2 text-sm text-gray-700 hover:bg-slate-50 hover:text-blue-700 transition-colors"
                      onClick={() => setActiveDropdown(null)}
                    >
                      {sub.title}
                    </Link>
                  )
                ))}
              </div>
            )}
          </div>
        ))}
      </nav>

      {/* Right Side: Notifications & User Menu */}
      <div className="flex items-center h-full pl-2 sm:pl-4 space-x-2 sm:space-x-3 border-l border-gray-100 w-auto justify-end relative">
         
         {/* Notification Bell */}
         <div className="relative">
            <button 
              onClick={() => toggleDropdown("Notifications")}
              className="p-1.5 text-gray-500 hover:bg-gray-100 rounded-full transition-colors relative"
            >
              <Bell className="w-5 h-5" />
              <span className="absolute top-1 right-1 w-2 h-2 bg-red-500 rounded-full border border-white"></span>
            </button>
            
            {activeDropdown === "Notifications" && (
               <div className="absolute top-10 right-0 w-64 bg-white border border-gray-100 rounded-md shadow-lg py-2 z-50 animate-in fade-in slide-in-from-top-2">
                 <div className="px-4 py-2 font-semibold text-sm border-b border-gray-50 text-gray-700">Benachrichtigungen</div>
                 {notifications.length > 0 ? notifications.map((notif, i) => (
                   <div key={i} className="px-4 py-3 hover:bg-slate-50 cursor-pointer border-b border-gray-50 last:border-0">
                      <p className="text-sm text-gray-800">{notif.title}</p>
                      <p className="text-xs text-gray-400 mt-1">{notif.time}</p>
                   </div>
                 )) : (
                   <div className="px-4 py-3 text-sm text-gray-500 text-center">Keine neuen Benachrichtigungen</div>
                 )}
               </div>
            )}
         </div>

         {/* User Dropdown Button */}
         <div className="relative">
           <button 
             onClick={() => toggleDropdown("UserMenu")}
             className={`flex items-center space-x-1 sm:space-x-2 px-2 sm:px-3 py-1.5 rounded-md transition-colors border ${activeDropdown === "UserMenu" ? "bg-gray-100 border-gray-200" : "bg-gray-50 border-gray-100 hover:bg-gray-100"}`}
           >
              <UserCircle className="w-5 h-5 text-gray-700" />
              <span className="hidden xs:inline text-sm font-medium text-gray-700">nexoroadmin</span>
              <ChevronDown className="w-4 h-4 text-gray-500" />
           </button>

           {/* User Dropdown Menu */}
           {activeDropdown === "UserMenu" && (
             <div className="absolute top-10 right-0 w-56 bg-white border border-gray-100 rounded-md shadow-lg py-1 z-50 animate-in fade-in slide-in-from-top-2">
                
                {/* Einloggen als with nested menu */}
                <div 
                  className="relative group"
                  onMouseEnter={() => setActiveSubMenu("LoginAs")}
                  onMouseLeave={() => setActiveSubMenu(null)}
                >
                  <button className="w-full flex items-center justify-between px-4 py-2 text-sm text-gray-700 hover:bg-slate-50">
                    <div className="flex items-center space-x-2">
                      <Users className="w-4 h-4 text-gray-500" />
                      <span>Einloggen als</span>
                    </div>
                    <ChevronRight className="w-4 h-4 text-gray-400" />
                  </button>
                  
                  {/* Nested submenu for Login As */}
                  {activeSubMenu === "LoginAs" && (
                    <div className="absolute top-0 right-full w-48 mr-1 bg-white border border-gray-100 rounded-md shadow-lg py-1 z-50">
                       <Link href="#" className="block px-4 py-2 text-sm text-gray-700 hover:bg-blue-50 hover:text-blue-700 border-b border-gray-50">
                         nexoroadmin
                       </Link>
                       <Link href="#" className="block px-4 py-2 text-sm text-gray-700 hover:bg-blue-50 hover:text-blue-700 border-b border-gray-50">
                         Hauptnummernrouting
                       </Link>
                       <Link href="#" className="block px-4 py-2 text-sm text-gray-700 hover:bg-blue-50 hover:text-blue-700">
                         demo
                       </Link>
                    </div>
                  )}
                </div>

                <div className="h-px bg-gray-100 my-1 mx-2"></div>

                <Link href="/zeiterfassung" className="block px-4 py-2 text-sm text-gray-700 hover:bg-slate-50 transition-colors">
                  Meine Zeiterfassung
                </Link>
                <Link href="/faq" className="block px-4 py-2 text-sm text-gray-700 hover:bg-slate-50 transition-colors">
                  FAQ
                </Link>
                
                <div className="h-px bg-gray-100 my-1 mx-2"></div>
                
                <Link href="/einstellungen" className="flex items-center px-4 py-2 text-sm text-gray-700 hover:bg-slate-50 transition-colors">
                  <Settings className="w-4 h-4 mr-2 text-gray-500" />
                  Usereinstellungen
                </Link>
                <Link href="/login" className="flex items-center px-4 py-2 text-sm text-red-600 hover:bg-red-50 transition-colors mt-1">
                  <LogOut className="w-4 h-4 mr-2" />
                  Abmelden
                </Link>
             </div>
           )}
         </div>
      </div>

      {/* Mobile Menu Overlay */}
      {isMobileMenuOpen && (
        <div className="md:hidden fixed inset-0 top-16 bg-white z-40 overflow-y-auto animate-in slide-in-from-left duration-200">
          <div className="flex flex-col p-4 space-y-2">
            {menuItems.map((item, index) => (
              <div key={index} className="border-b border-gray-100 pb-2">
                {item.href && !item.subItems ? (
                  <Link 
                    href={item.href} 
                    className="flex items-center space-x-3 p-2 text-gray-700 hover:bg-gray-50 rounded-md"
                    onClick={() => setIsMobileMenuOpen(false)}
                  >
                    <div className="w-8 flex justify-center">{item.icon}</div>
                    <span className="font-semibold uppercase tracking-wider text-xs">{item.title}</span>
                  </Link>
                ) : (
                  <div className="flex flex-col">
                    <button 
                      onClick={() => toggleDropdown(item.title)}
                      className="flex items-center justify-between p-2 text-gray-700 hover:bg-gray-50 rounded-md w-full"
                    >
                      <div className="flex items-center space-x-3">
                        <div className="w-8 flex justify-center">{item.icon}</div>
                        <span className="font-semibold uppercase tracking-wider text-xs">{item.title}</span>
                        {item.count !== undefined && (
                          <span className="text-[9px] bg-[#ef4444] text-white rounded-full px-1.5 py-0 min-w-[16px] text-center ml-1">
                            {item.count}
                          </span>
                        )}
                      </div>
                      <ChevronDown className={`w-4 h-4 text-gray-400 transition-transform ${activeDropdown === item.title ? "rotate-180" : ""}`} />
                    </button>
                    
                    {activeDropdown === item.title && item.subItems && (
                      <div className="pl-11 pr-4 py-2 space-y-2 flex flex-col bg-gray-50 rounded-md mt-1">
                        {item.subItems.map((sub, idx) => (
                          !sub.divider && (
                            <Link 
                              key={idx} 
                              href={sub.href}
                              className="text-sm text-gray-600 hover:text-blue-700"
                              onClick={() => setIsMobileMenuOpen(false)}
                            >
                              {sub.title}
                            </Link>
                          )
                        ))}
                      </div>
                    )}
                  </div>
                )}
              </div>
            ))}
            
            {/* Mobile Footer in Menu */}
            <div className="pt-6 border-t border-gray-100 flex flex-col space-y-4">
               <div className="flex items-center space-x-3 px-2">
                 <UserCircle className="w-6 h-6 text-gray-400" />
                 <div className="flex flex-col">
                   <span className="text-sm font-semibold text-gray-800">nexoroadmin</span>
                   <span className="text-xs text-gray-500">Administrator</span>
                 </div>
               </div>
               <Link 
                href="/login" 
                className="flex items-center space-x-3 p-2 text-red-600 hover:bg-red-50 rounded-md"
                onClick={() => setIsMobileMenuOpen(false)}
               >
                 <LogOut className="w-5 h-5 ml-1.5" />
                 <span className="text-sm font-semibold">Abmelden</span>
               </Link>
            </div>
          </div>
        </div>
      )}

    </header>
  );
}
