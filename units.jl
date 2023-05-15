module units 
    # export hPa
    # export g,kg,g_kg
    # export degC,K

    mutable struct hPa 
        v :: Float64
        
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
