import TopBar from "@/components/layout/TopBar";
import Sidebar from "@/components/layout/Sidebar";

export default function DashboardLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <div className="min-h-screen bg-gray-50 flex flex-col font-sans">
      <TopBar />
      
      <div className="flex flex-1 pt-20">
        <Sidebar />
        
        <main className="flex-1 overflow-x-hidden overflow-y-auto bg-gray-50 p-6 custom-scrollbar">
          <div className="max-w-7xl mx-auto">
             {children}
          </div>
        </main>
      </div>
    </div>
  );
}
