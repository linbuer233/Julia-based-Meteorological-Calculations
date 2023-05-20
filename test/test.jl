include("../src/calc.jl")
using Unitful
using .calc
## 大气压强
P0 = 1013.25u"hPa"
P = 988u"hPa"
M = 0.0289644u"kg/mol" # 空气中主要是氮气和氧气，二者摩尔质量的平均值约为28.97 kg/mol
g = 9.81u"m/s^2"
h = 500u"m"
R = 8.314u"J/(K*mol)"
# T = calc.units.degC(15)
T=288u"K"

println(typeof(P0))
println(P0.val)
println(typeof(T))
# println(methods(calc.atmospheric_pressure))
a=calc.atmospheric_pressure(P0,M,g,h,R,T)
println("ap\t",a)


# 计算相对湿度

temp=293u"K"
dew_temp=288u"K"

println("rh\t",calc.relative_humidity(temp,dew_temp))
println("ah\t",calc.absolute_humidity(temp))
println("q\t",calc.q(dew_temp,P))

temp=20u"°C"
println("theta\t",calc.theta(temp,P,P0))
println("temp_v\t",calc.temp_v_from_q(temp,10.69u"g/kg"))
println("temp_v\t",calc.temp_v(temp,P))