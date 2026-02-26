import React from 'react';

interface DashboardGridProps {
  children: React.ReactNode;
}

export const DashboardGrid: React.FC<DashboardGridProps> = ({ children }) => {
  return (
    <div className="grid grid-cols-1 xl:grid-cols-12 gap-6 p-6 max-w-[1600px] mx-auto">
      {/* Container for left column - Chart, Calendar, Notes */}
      <div className="xl:col-span-7 space-y-6">
        {React.Children.map(children, (child, index) => {
          if ([0, 1, 6].includes(index)) return child;
          return null;
        })}
      </div>
      
      {/* Container for right column - Emails, Attention, Tasks, Leads */}
      <div className="xl:col-span-5 space-y-6">
        {React.Children.map(children, (child, index) => {
          if ([2, 3, 4, 5].includes(index)) return child;
          return null;
        })}
      </div>
    </div>
  );
};
