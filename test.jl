include("./calc.jl")
using .calc


## 大气压强
P0 = 101325
P=80000
M = 0.0289644 # 空气中主要是氮气和氧气，二者摩尔质量的平均值约为0.0289644 kg/mol
g = 9.81
h = 1000
R = 8.314
T = 288

a=calc.atmospheric_pressure(P0,M,g,h,R,T)
println("ap\t",a)


# 计算相对湿度

temp=20
dew_temp=15

println("rh\t",calc.relative_humidity(temp,dew_temp))
println("ah\t",calc.absolute_humidity(temp))
println("q\t",calc.q(temp,P0/100))
println("theta\t",calc.theta(temp,P,P0))