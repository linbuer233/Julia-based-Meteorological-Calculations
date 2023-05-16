module unitsconvert
    export K2degC,degC2K
    function K2degC(Tk)
            return Tk.v-273.15
    end
    function degC2K(Tk)
        return Tk.v+273.15
    end
end

abstract type Symbol end
abstract type Unit <: Symbol end
abstract type Pressure <: Unit end
abstract type Mass <: Unit end
abstract type Temperature <: Unit end


struct hPa <: Pressure end
struct per_hPa <: Pressure end

# 质量
struct g <: Mass end
struct kg <: Mass end
struct g_per_kg <: Mass end
struct kg_per_kg <: Mass end


# 温度
struct degC <: Temperature end
struct K <: Temperature end


# 类型定义
mutable struct Quantity{V<:Number, U<:Unit}
        value::V
        unit::U
end

a = Quantity(1.0, hPa())
println(a::Quantity)