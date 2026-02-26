import { redirect } from 'next/navigation';

export default function DashboardIndex() {
  // Normally we would check for a session via cookies() here
  // and redirect to /login if there isn't one.
  // For the demo purpose, we assume the user is "logged in" when they see this layout
  
  return (
    <div className="bg-white rounded-xl shadow-sm border border-gray-100 p-8">
      <h1 className="text-2xl font-bold text-gray-800 mb-4">Willkommen im neuen Nexoro Dashboard</h1>
      <p className="text-gray-600 mb-6">
        Das Dashboard wurde erfolgreich mit Next.js und Tailwind CSS neu aufgebaut. 
        Nutze die Navigation oben oder die Filter links, um Aufträge, Kunden und Aufgaben zu verwalten.
      </p>
      
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mt-8">
         <div className="p-6 bg-blue-50 bg-opacity-50 rounded-lg border border-blue-100">
           <h3 className="font-semibold text-blue-800 mb-2">Offene Aufträge</h3>
           <p className="text-3xl font-bold text-blue-600">12</p>
         </div>
         <div className="p-6 bg-green-50 bg-opacity-50 rounded-lg border border-green-100">
           <h3 className="font-semibold text-green-800 mb-2">Neukunden (Heute)</h3>
           <p className="text-3xl font-bold text-green-600">3</p>
         </div>
         <div className="p-6 bg-purple-50 bg-opacity-50 rounded-lg border border-purple-100">
           <h3 className="font-semibold text-purple-800 mb-2">Anrufe in Warteschlange</h3>
           <p className="text-3xl font-bold text-purple-600">0</p>
         </div>
      </div>
    </div>
  );
}
