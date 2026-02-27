import * as React from "react"
import { Check } from "lucide-react"

const Checkbox = React.forwardRef<HTMLInputElement, any>(({ className, checked, onCheckedChange, ...props }, ref) => (
  <div 
    className={`peer h-4 w-4 shrink-0 rounded-sm border border-blue-600 ring-offset-white focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-blue-600 focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50 flex items-center justify-center cursor-pointer transition-colors ${checked ? 'bg-blue-600 text-white' : 'bg-white'}`}
    onClick={() => onCheckedChange?.(!checked)}
  >
    {checked && <Check className="h-3 w-3" />}
  </div>
))
Checkbox.displayName = "Checkbox"

export { Checkbox }
