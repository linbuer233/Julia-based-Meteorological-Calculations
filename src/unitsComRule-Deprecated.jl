include("./units-Deprecated.jl")
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
import Base:exp



# P0.v .* exp(-M .* g .* h ./ (R .* (T.v+273.15)))
# /
/(x::Quantity, y::Quantity)=Quantity(x.value/y.value,x.unit/y.unit)

/(x::Quantity, y::Number)=Quantity(x.value/y,x.unit)
/(x::Number, y::Quantity)=Quantity(x/y.value,1/y.unit)

/(x::Number, y::hPa)=per_hPa()
/(x::Number, y::degC)=per_degC()
/(x::g, y::kg)=g_per_kg()

# +
function +(x::Quantity,y::Quantity)
    if supertype(typeof(x.unit))!=supertype(typeof(y.unit))
        error("Units do not match")
    end
    x=unitsconvert(x,y)
    ################################################################
    return Quantity(x.value+y.value,y.unit)
end
function +(x::Quantity,y::Number)
    return Quantity(x.value+y,x.unit)
end

# *
*(x::Quantity,y::Quantity) =Quantity(x.value*y.value,x.unit*y.unit)

*(x::Number,y::Quantity)=Quantity(x*y.value,y.unit)

*(x::hPa,y::per_degC)=hPa_per_degC()


# exp 
exp(x::Quantity)=Quantity(exp(x.value),x.unit)

println("/////##############################")
a=Quantity(1000,hPa())
b=a/10
println(b)
c=10000/a
println("a\t",a.unit)
println(c)
println("++++##############################")
a=Quantity(1000,g())
b=Quantity(1,kg())
d=Quantity(1000,hPa())
c=a/b
println(c)
println(a+b)

println("*******************************")
## 大气压强
P0 = Quantity(1013.25,hPa())
P = Quantity(800,hPa())
M = 0.0289644 # 空气中主要是氮气和氧气，二者摩尔质量的平均值约为0.0289644 kg/mol
g1 = 9.81
h = 193
R = 8.314
T=Quantity(15,degC())

a1=T+273.15 
a2=R * a1
a3=-M * g1 * h
a4=a3 / a2
println(P0 * exp(a4))
println(g()/kg())