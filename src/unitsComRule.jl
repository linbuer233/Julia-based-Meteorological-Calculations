##################################单位统一##################################





################################添加运算方法################################
import Base:/
import Base:*
import Base:-
import Base:+

include("./units.jl")

# P0.v .* exp(-M .* g .* h ./ (R .* (T.v+273.15)))
/(x::Quantity, y::Number)=Quantity(x.value/y,x.unit)
/(x::Number, y::Quantity)=Quantity(x/y.value,1/y.unit)

/(x::Quantity, y::Quantity)=Quantity(x.value/y.value,x.unit/y.unit)

/(x::Number, y::hPa)=per_hPa()
/(x::g, y::kg)=g_per_kg()

function +(x::Quantity,y::Quantity)
    
end   

a=Quantity(1000,hPa())
b=a/10
println(b)
c=10000/a
println(c)

a=Quantity(1000,g())
b=Quantity(1,kg())
c=a/b
println(c)
# println(typeof(b.v))