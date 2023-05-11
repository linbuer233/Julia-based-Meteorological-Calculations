include("./calc.jl")
include("./units.jl")
# using .units
using .calc
import .calc.units as cunits
cunits.hPa

## 大气压强
P0 = cunits.hPa(1013.25)
P = cunits.hPa(800)
M = 0.0289644 # 空气中主要是氮气和氧气，二者摩尔质量的平均值约为0.0289644 kg/mol
g = 9.81
h = 193
R = 8.314
# T = calc.units.degC(15)
T=cunits.K(288)
println(typeof(P0))
println(typeof(T))
# println(methods(calc.atmospheric_pressure))
a=calc.atmospheric_pressure(P0,M,g,h,R,T)
println("ap\t",a)


# 计算相对湿度

temp=cunits.K(293)
dew_temp=cunits.K(288)

println("rh\t",calc.relative_humidity(temp,dew_temp))
println("ah\t",calc.absolute_humidity(temp))
println("q\t",calc.q(temp,P0))
println("theta\t",calc.theta(temp,P,P0))