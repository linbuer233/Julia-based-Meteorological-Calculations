include("./units.jl")
##################################单位统一##################################
function unitsconvert(x::Quantity, y::Quantity)
    function uconvert(a::g,b::kg)
        return 1/1000
    end
    function uconvert(x::kg,y::g)
        return 1000
    end
    ############只是把单位统一为两者中的一个##############
    x.value=uconvert(x.unit,y.unit) * x.value
    return x
end





################################添加运算方法################################
import Base:/
import Base:*
import Base:-
import Base:+



# P0.v .* exp(-M .* g .* h ./ (R .* (T.v+273.15)))
/(x::Quantity, y::Number)=Quantity(x.value/y,x.unit)
/(x::Number, y::Quantity)=Quantity(x/y.value,1/y.unit)

/(x::Quantity, y::Quantity)=Quantity(x.value/y.value,x.unit/y.unit)

/(x::Number, y::hPa)=per_hPa()
/(x::g, y::kg)=g_per_kg()

function +(x::Quantity,y::Quantity)
    if supertype(typeof(x.unit))!=supertype(typeof(y.unit))
        error("Units do not match")
    end
    x=unitsconvert(x,y)
    ################################################################
    return Quantity(x.value+y.value,y.unit)
end   

a=Quantity(1000,hPa())
b=a/10
println(b)
c=10000/a
println("a\t",a.unit)
println(c)

a=Quantity(1000,g())
b=Quantity(1,kg())
d=Quantity(1000,hPa())
c=a/b
println(c)
println(a+b)