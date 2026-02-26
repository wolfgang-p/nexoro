import React from 'react';

interface DashboardGridProps {
  children: React.ReactNode;
}

export const DashboardGrid: React.FC<DashboardGridProps> = ({ children }) => {
  const childrenArray = React.Children.toArray(children);
  
  return (
    <div className="grid grid-cols-1 xl:grid-cols-12 gap-6 p-4 md:p-6 lg:px-2 max-w-[1800px] mx-auto">
      {/* Container for left column - Chart, Calendar, Notes */}
      <div className="xl:col-span-7 space-y-6">
        {childrenArray[0]}
        {childrenArray[1]}
        {childrenArray[6]}
      </div>
      
      {/* Container for right column - Emails, Attention, Tasks, Leads */}
      <div className="xl:col-span-5 space-y-6">
        {childrenArray[2]}
        {childrenArray[3]}
        {childrenArray[4]}
        {childrenArray[5]}
      </div>
    </div>
  );
};
