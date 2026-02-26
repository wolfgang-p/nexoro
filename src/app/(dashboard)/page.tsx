import { DashboardGrid } from '@/components/dashboard/DashboardGrid';
import { DashboardCard } from '@/components/dashboard/DashboardCard';
import { NewCustomersChart } from '@/components/dashboard/widgets/NewCustomersChart';
import { EmailList } from '@/components/dashboard/widgets/EmailList';
import { OverdueOrders } from '@/components/dashboard/widgets/OverdueOrders';
import { TaskList } from '@/components/dashboard/widgets/TaskList';
import { LeadsList } from '@/components/dashboard/widgets/LeadsList';
import { CalendarWidget } from '@/components/dashboard/widgets/CalendarWidget';
import { NotesWidget } from '@/components/dashboard/widgets/NotesWidget';

export default function DashboardPage() {
  return (
    <div className="min-h-screen bg-slate-50/30 pb-12">
      <DashboardGrid>
        {/* Index 0: Chart (Left) */}
        <DashboardCard 
          title="Neukunden (letzte 30 Tage)" 
          subtitle="Trendentwicklung der Auftragseingänge"
        >
          <NewCustomersChart />
        </DashboardCard>

        {/* Index 1: Calendar (Left) */}
        <DashboardCard 
          title="Kalender (Tag)" 
          subtitle="Ihre anstehenden Termine"
        >
          <CalendarWidget />
        </DashboardCard>

        {/* Index 2: Emails (Right) */}
        <DashboardCard 
          title="Eingehende E-Mails" 
          subtitle="Posteingang (INBOX)"
          meta={<span className="bg-blue-100 text-blue-700 px-2 py-0.5 rounded-full font-bold">Live</span>}
        >
          <EmailList />
        </DashboardCard>

        {/* Index 3: Attention (Right) */}
        <DashboardCard 
          title="Aufträge mit Handlungsbedarf" 
          subtitle="Status-Überfälligkeiten"
        >
          <OverdueOrders />
        </DashboardCard>

        {/* Index 4: Tasks (Right) */}
        <DashboardCard 
          title="Aufgaben" 
          subtitle="Persönlich & Gruppe"
        >
          <TaskList />
        </DashboardCard>

        {/* Index 5: Leads (Right) */}
        <DashboardCard 
          title="Neue Leads" 
          subtitle="Chronologisch neueste Aufträge"
        >
          <LeadsList />
        </DashboardCard>

        {/* Index 6: Notes (Left) */}
        <DashboardCard 
          title="Persönliche Notizen" 
          subtitle="Nur für Sie sichtbar (Lokal)"
        >
          <NotesWidget />
        </DashboardCard>
      </DashboardGrid>
    </div>
  );
}
