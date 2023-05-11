module calc
    #TODO:创建新的类型以便识别各种情况
    export e
    # 大气压强
    # https://latex.codecogs.com/svg.image?&space;P=P_0e^{-\frac{Mgh}{RT}}
    function atmospheric_pressure(P0, M, g, h, R, T)
        return P0 .* exp(-M.* g .* h ./(R .* T))
    end
    #############################湿度特征参量#############################
    # 水汽压
    # https://latex.codecogs.com/svg.image?&space;e=6.11\times10%20^{\frac{7.5\times%20t}{237.3\times%20t}}
    function e(temp)
        # return 6.11 .* 10^((7.5 .* temp) ./ (237.3 .+ temp))
        return 6.112 .* exp(17.67 .* temp./(temp+243.5))
    end
    
    # 计算相对湿度 
    function relative_humidity(temp, dew_temp) # 单位为摄氏度 
        es = e(temp) # 饱和水汽压力
        en = e(dew_temp) # 实际水汽压力
        rh = en ./ es * 100 # 相对湿度
        return rh
    end

    # 绝对湿度
    function absolute_humidity(temp)
        return 0.217 .* e(temp) ./ temp .* 100
    end

    # 比湿 （饱和比湿）
    function q(temp,P)
        return 622 .* e(temp) ./ (P .- 0.378 .* e(temp))  # 单位(g/kg)
    end

    # 混合比
    function Wq(temp,P)
        return 622 .* e(temp) ./ (P .-e(temp))
    end

    #############################温度特征参量#############################
    # 位温
    function theta(temp,P,P0)
        return temp .* (P0 ./ P)^0.286
    end

    # 绝对虚温 
    function temp_v(temp,q) # q为(g/g)
        return (1 .+ 0.61 .* q).*temp
    end
    export q   
    function temp_v(temp,P)
        return (1 .+ 0.61 .* q(temp,P) ./1000) .* temp
    end
end
