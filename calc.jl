module calc
    export e
    # 大气压强
    # https://latex.codecogs.com/svg.image?&space;P=P_0e^{-\frac{Mgh}{RT}}
    function atmospheric_pressure(P0, M, g, h, R, T)
        return P0 * exp(-M*g*h/(R*T))
    end
    
    # 水汽压
    # https://latex.codecogs.com/svg.image?&space;e=6.11\times10%20^{\frac{7.5\times%20t}{237.3\times%20t}}
    function e(temp)
        return 6.11 * 10^((7.5 .* temp) ./ (237.3+ temp))
    end
    
    # 计算相对湿度 
    function relative_humidity(temp, dew_temp) # 单位为摄氏度 
        es = e(temp) # 饱和水汽压力
        en = e(dew_temp) # 实际水汽压力
        rh = en ./ es * 100 # 相对湿度
        return rh
    end    
end
