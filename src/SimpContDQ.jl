module SimpContDQ

import REPL
using REPL.TerminalMenus

using Statistics, Dates, LinearAlgebra
using LibSerialPort, AngleBetweenVectors

export main, close_all

include("leds.jl")

# const O = Observable
const strip = Ref{Union{Nothing, Strip}}(nothing)

function __init__()
  strip[] = Strip()
end

function reset()
  isnothing(strip[]) || close(strip[])
  strip[] = Strip()
end


# function main(; azimuths = string.(round.(Int, range(0, step = 360/nleds, length = nleds))))
#
#   reset()
#   menu = RadioMenu(azimuths)
#
#   while true
#     choice = request("Choose sun-azimuth:", menu)
#     if choice ≠ -1
#       update_buffer!(strip[].buffer, 0, 255, 0, choice, choice)
#       write(strip[].sp, strip[].buffer)
#     else
#       println("No choice, no change")
#     end
#   end
#
#   nothing
# end

function main()

  reset()

  txt = ""
  while txt ≠ "q"
    println("Choose sun-azimuth:")
    txt = readline()
    try 
      α = parse(Int, txt)
      update_strip!(strip[], 0, 255, 0, 1, deg2rad(α))
    catch ex
      if ex isa ArgumentError
        continue
      else
        throw(ex)
      end
    end
  end
end



end
