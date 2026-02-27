import * as React from "react"
import { ChevronDown } from "lucide-react"

const Select = ({ children, onValueChange, defaultValue }: { children: React.ReactNode, onValueChange?: (v: string) => void, defaultValue?: string }) => {
  const [value, setValue] = React.useState(defaultValue || "")
  const [isOpen, setIsOpen] = React.useState(false)
  const containerRef = React.useRef<HTMLDivElement>(null)

  React.useEffect(() => {
    const handleClickOutside = (event: MouseEvent) => {
      if (containerRef.current && !containerRef.current.contains(event.target as Node)) {
        setIsOpen(false)
      }
    }
    document.addEventListener("mousedown", handleClickOutside)
    return () => document.removeEventListener("mousedown", handleClickOutside)
  }, [])
  
  return (
    <div className="relative w-full" ref={containerRef}>
      {React.Children.map(children, child => {
        if (React.isValidElement(child)) {
          return React.cloneElement(child as React.ReactElement<any>, { 
            value, 
            setValue, 
            isOpen, 
            setIsOpen, 
            onValueChange 
          })
        }
        return child
      })}
    </div>
  )
}

const SelectTrigger = React.forwardRef<HTMLDivElement, any>(({ className, children, value, isOpen, setIsOpen, ...props }, ref) => (
  <div
    ref={ref}
    onClick={() => setIsOpen(!isOpen)}
    className={`flex h-10 w-full cursor-pointer items-center justify-between rounded-md border border-slate-200 bg-white px-3 py-2 text-sm ring-offset-white placeholder:text-slate-500 focus:outline-none focus:ring-2 focus:ring-blue-600 focus:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50 ${className}`}
    {...props}
  >
    {children}
    <ChevronDown className={`h-4 w-4 opacity-50 transition-transform ${isOpen ? 'rotate-180' : ''}`} />
  </div>
))

const SelectValue = ({ placeholder, value }: { placeholder?: string, value?: string }) => (
  <span className={!value ? "text-slate-500" : ""}>{value || placeholder}</span>
)

const SelectContent = ({ children, value, setValue, isOpen, setIsOpen, onValueChange }: any) => {
  if (!isOpen) return null;
  return (
    <div className="absolute top-11 z-[100] min-w-[8rem] w-full overflow-hidden rounded-md border border-slate-200 bg-white text-slate-950 shadow-md animate-in fade-in-80 slide-in-from-top-1">
      <div className="p-1">
        {React.Children.map(children, child => {
          if (React.isValidElement(child)) {
            return React.cloneElement(child as any, { 
              active: (child as any).props.value === value,
              onClick: () => {
                setValue((child as any).props.value)
                onValueChange?.((child as any).props.value)
                setIsOpen(false)
              }
            })
          }
          return child
        })}
      </div>
    </div>
  )
}

const SelectItem = React.forwardRef<HTMLDivElement, any>(({ className, children, active, ...props }, ref) => (
  <div
    ref={ref}
    className={`relative flex w-full cursor-default select-none items-center rounded-sm py-1.5 pl-8 pr-2 text-sm outline-none hover:bg-slate-100 data-[disabled]:pointer-events-none data-[disabled]:opacity-50 ${active ? 'bg-slate-100' : ''} ${className}`}
    {...props}
  >
    <span className="absolute left-2 flex h-3.5 w-3.5 items-center justify-center">
      {active && <div className="h-2 w-2 rounded-full bg-blue-600" />}
    </span>
    {children}
  </div>
))

export { Select, SelectTrigger, SelectValue, SelectContent, SelectItem }
