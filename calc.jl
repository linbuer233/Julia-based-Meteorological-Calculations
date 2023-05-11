

module calc
    include("./units.jl")
    import .units
    include("./unitsconvert.jl")
    using .unitsconvert

    export e,q
    
    # 大气压强
    # https://latex.codecogs.com/svg.image?&space;P=P_0e^{-\frac{Mgh}{RT}}
    function atmospheric_pressure(P0::units.hPa, M, g, h, R, T::units.degC)
        return P0.v .* exp(-M.* g .* h ./(R .* (T.v+273.15)))
    end
    function atmospheric_pressure(P0::units.hPa, M, g, h, R, T::units.K)
        return P0.v .* exp(-M.* g .* h ./(R .* T.v))
    end

    #############################湿度特征参量#############################
    # 水汽压
    # https://latex.codecogs.com/svg.image?&space;e=6.11\times10%20^{\frac{7.5\times%20t}{237.3\times%20t}}
    function e(temp)
        # return 6.11 .* 10^((7.5 .* temp) ./ (237.3 .+ temp))
        return 6.112 .* exp(17.67 .* temp ./ (temp+243.5))
    end
    
    # 计算相对湿度 
    function relative_humidity(temp::units.K, dew_temp::units.K) # 单位为摄氏度 
        temp.v=K2degC(temp)
        dew_temp.v=K2degC(dew_temp)
        es = e(temp.v) # 饱和水汽压力
        en = e(dew_temp.v) # 实际水汽压力
        rh = en ./ es * 100 # 相对湿度
        return rh
    end
    function relative_humidity(temp::units.degC, dew_temp::units.degC) # 单位为摄氏度 
        es = e(temp.v) # 饱和水汽压力
        en = e(dew_temp.v) # 实际水汽压力
        rh = en ./ es * 100 # 相对湿度
        return rh
    end

    # 绝对湿度
    function absolute_humidity(temp::units.K) 
        return 0.217 .* e(temp.v) ./ temp.v .* 100
    end
    function absolute_humidity(temp::units.degC) 
        temp.v=degC2K(temp)
        return 0.217 .* e(temp.v) ./ temp.v .* 100
    end

    # 比湿 （饱和比湿）
    function q(temp::units.K,P::units.hPa)
        return 622 .* e(temp.v) ./ (P.v .- 0.378 .* e(temp.v))  # 单位(g/kg)
    end
    function q(temp::units.degC,P::units.hPa)
        temp.v =K2degC(temp)
        return 622 .* e(temp.v) ./ (P.v .- 0.378 .* e(temp.v))  # 单位(g/kg)
    end

    # 混合比
    function Wq(temp::units.K,P::units.hPa)
        temp.v=K2degC(temp)
        return 622 .* e(temp.v) ./ (P.v .- e(temp.v))
    end
    function Wq(temp::units.degC,P::units.hPa)
        return 622 .* e(temp.v) ./ (P.v .- e(temp.v))
    end

    #############################温度特征参量#############################
    # 位温
    function theta(temp::units.K,P::units.hPa,P0::units.hPa)
        return temp.v .* (P0.v ./ P.v)^0.286 # K
    end
    function theta(temp::units.degC,P::units.hPa,P0::units.hPa)
        temp.v =degC2K(temp)
        return temp.v .* (P0.v ./ P.v)^0.286 # K
    end

    # 绝对虚温 
    function temp_v(temp::units.K,q) # q为(g/g)
        return (1 .+ 0.61 .* q).*temp.v
    end
    function temp_v(temp::units.degC,q) # q为(g/g)
        temp.v=degC2K(temp::units.degC)
        return (1 .+ 0.61 .* q).*temp.v
    end
    function temp_v(temp::units.degC,P::units.hPa) # q为(g/g)
        temp.v=degC2K(temp)
        return (1 .+ 0.61 .* q(temp,P) ./1000) .* temp.v
    end
    function temp_v(temp::units.K,P::units.hPa) # q为(g/g)
        return (1 .+ 0.61 .* q(temp,P) ./1000) .* temp.v
    end
end
