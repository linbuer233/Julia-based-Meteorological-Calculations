module unitsconvert
    export K2degC,degC2K

    function K2degC(Tk)
            return Tk.v-273.15
    end
    function degC2K(Tk)
        return Tk.v+273.15
    end
end

module units 
    # export hPa
    # export g,kg,g_kg
    # export degC,K
    mutable struct hPa 
        v :: Number
    end
    # 质量单位
    mutable struct g 
        v :: Float64
    end
    mutable struct kg 
        v :: Float64
    end
    mutable struct g_kg 
        v::Float64
    end

    # 温度 
    mutable struct degC 
        v :: Float64
    end
    mutable struct K
        v::Float64
    end

end
