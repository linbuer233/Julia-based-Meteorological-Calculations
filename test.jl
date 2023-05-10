include("./calc.jl")
using .calc


## 大气压强
P0 = 101325
M = 0.0289644 # 空气中主要是氮气和氧气，二者摩尔质量的平均值约为0.0289644 kg/mol
g = 9.81
h = 1000
R = 8.314
T = 288

a=calc.atmospheric_pressure(P0,M,g,h,R,T)
println(a)


# 计算相对湿度

temp=20
dew_temp=15

println(calc.relative_humidity(temp,dew_temp))