'use client';

import React, { useEffect, useState } from 'react';
import { AlertTriangle, Clock } from 'lucide-react';

interface OverdueOrder {
  id: number;
  auftragsnummer: string;
  customer: string;
  reason: string;
  level: 'hoch' | 'mittel' | 'niedrig';
}

export const OverdueOrders: React.FC = () => {
  const [orders, setOrders] = useState<OverdueOrder[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch('/api/dashboard/orders-attention')
      .then(res => res.json())
      .then(d => {
        setOrders(Array.isArray(d) ? d : []);
        setLoading(false);
      })
      .catch(() => setLoading(false));
  }, []);

  if (loading) return <div className="space-y-4">{[1,2].map(i => <div key={i} className="h-16 bg-slate-50 animate-pulse rounded-lg" />)}</div>;

  if (orders.length === 0) return <div className="text-center py-8 text-slate-400 text-sm">Alles im Plan</div>;

  const levelColors = {
    hoch: 'bg-red-50 text-red-700 border-red-100',
    mittel: 'bg-amber-50 text-amber-700 border-amber-100',
    niedrig: 'bg-slate-50 text-slate-700 border-slate-100'
  };

  return (
    <div className="space-y-3">
      {orders.map((order) => (
        <div 
          key={order.id} 
          className={`p-3 rounded-xl border flex gap-3 items-start ${levelColors[order.level]}`}
        >
          <div className="mt-0.5">
            {order.level === 'hoch' ? <AlertTriangle size={16} /> : <Clock size={16} />}
          </div>
          <div className="flex-1 min-w-0">
            <div className="flex justify-between items-center">
              <span className="text-sm font-bold truncate">#{order.auftragsnummer}</span>
              <span className="text-[10px] uppercase tracking-wider font-bold opacity-75">{order.level}</span>
            </div>
            <p className="text-xs font-medium truncate mt-0.5">{order.customer}</p>
            <p className="text-[11px] opacity-80 mt-1">{order.reason}</p>
          </div>
        </div>
      ))}
    </div>
  );
};
