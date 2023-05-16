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

struct hPa <: Unit end
struct per_hPa <: Unit end

# 质量
struct g <: Unit end
struct kg <: Unit end
struct g_per_kg <: Unit end
struct kg_per_kg <: Unit end


# 温度
struct degC <: Unit end
struct K <: Unit end
mutable struct Quantity{V<:Number, U<:Unit}
        value::V
        unit::U
end
a = Quantity(1.0, hPa())
println(a::Quantity)