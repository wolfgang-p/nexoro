import * as React from "react"

const Tabs = ({ children, defaultValue, className }: any) => {
  const [value, setValue] = React.useState(defaultValue)
  return (
    <div className={className}>
      {React.Children.map(children, child => {
        if (React.isValidElement(child)) {
          return React.cloneElement(child as React.ReactElement<any>, { activeValue: value, setActiveValue: setValue })
        }
        return child
      })}
    </div>
  )
}

const TabsList = ({ children, activeValue, setActiveValue, className }: any) => (
  <div className={`inline-flex items-center justify-center rounded-md bg-slate-100 p-1 text-slate-500 ${className}`}>
    {React.Children.map(children, child => {
      if (React.isValidElement(child)) {
        return React.cloneElement(child as any, { 
          active: (child as any).props.value === activeValue,
          onClick: () => setActiveValue((child as any).props.value)
        })
      }
      return child
    })}
  </div>
)

const TabsTrigger = ({ children, active, onClick, className }: any) => (
  <button
    onClick={onClick}
    className={`inline-flex items-center justify-center whitespace-nowrap rounded-sm px-3 py-1.5 text-sm font-medium ring-offset-white transition-all focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-slate-950 focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 ${active ? 'bg-white text-slate-950 shadow-sm' : 'hover:bg-slate-200/50 hover:text-slate-900'} ${className}`}
  >
    {children}
  </button>
)

const TabsContent = ({ children, value, activeValue, className }: any) => {
  if (value !== activeValue) return null;
  return (
    <div className={`mt-2 ring-offset-white focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-slate-950 focus-visible:ring-offset-2 animate-in fade-in-50 duration-200 ${className}`}>
      {children}
    </div>
  )
}

export { Tabs, TabsList, TabsTrigger, TabsContent }
