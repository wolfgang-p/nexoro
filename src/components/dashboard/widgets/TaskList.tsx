'use client';

import React, { useEffect, useState } from 'react';
import { CheckCircle2, Circle, Users, User } from 'lucide-react';

interface Task {
  id: number;
  was: string;
  wann?: string;
  groupName?: string;
  assigned: 'user' | 'group';
}

export const TaskList: React.FC = () => {
  const [tasks, setTasks] = useState<Task[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch('/api/dashboard/tasks')
      .then(res => res.json())
      .then(d => {
        setTasks(Array.isArray(d) ? d : []);
        setLoading(false);
      })
      .catch(() => setLoading(false));
  }, []);

  if (loading) return <div className="space-y-4">{[1,2,3].map(i => <div key={i} className="h-12 bg-slate-50 animate-pulse rounded-lg" />)}</div>;

  if (tasks.length === 0) return <div className="text-center py-8 text-slate-400 text-sm">Keine ausstehenden Aufgaben</div>;

  return (
    <div className="space-y-2">
      {tasks.map((task) => (
        <div key={task.id} className="flex items-start gap-3 p-2 hover:bg-slate-50 rounded-lg group transition-colors">
          <button className="mt-0.5 text-slate-300 hover:text-green-500 transition-colors">
            <Circle size={18} />
          </button>
          <div className="flex-1 min-w-0">
            <p className="text-sm text-slate-700 font-medium line-clamp-2">{task.was}</p>
            <div className="flex items-center gap-2 mt-1">
              <span className="text-[10px] text-slate-400">
                {task.wann ? new Date(task.wann).toLocaleString('de-DE', { day: '2-digit', month: '2-digit', year: '2-digit', hour: '2-digit', minute: '2-digit' }) : 'Ohne Termin'}
              </span>
              <span className={`text-[10px] flex items-center gap-1 font-medium px-1.5 py-0.5 rounded-full ${task.assigned === 'user' ? 'bg-blue-50 text-blue-600' : 'bg-purple-50 text-purple-600'}`}>
                {task.assigned === 'user' ? <User size={10} /> : <Users size={10} />}
                {task.assigned === 'user' ? 'Persönlich' : task.groupName}
              </span>
            </div>
          </div>
        </div>
      ))}
    </div>
  );
};
