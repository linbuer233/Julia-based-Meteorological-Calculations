import Base:/
import Base:*
import Base:-
import Base:+

include("./units.jl")
using .units

mutable struct hPa 
    v :: Float64
end

function /(x::hPa, y::Number)
    return hPa(x.v / y)
end

a=hPa(1000)
b=a/10

