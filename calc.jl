module calc
    # 大气压强
    # https://latex.codecogs.com/svg.image?&space;P=P_0e^{-\frac{Mgh}{RT}}
    function atmospheric_pressure(P0, M, g, h, R, T)
        return P0 * exp(-M*g*h/(R*T))
    end
    # 计算相对湿度 
    function relative_humidity(temp, dew_temp) # 单位为摄氏度 
        es = 6.11 * 10^((7.5 .* temp) ./ (237.3+ temp)) # 饱和水汽压力
        e = 6.11 * 10^((7.5 .* dew_temp) ./ (237.3+ dew_temp)) # 实际水汽压力
        rh = e ./ es * 100 # 相对湿度
        return rh
    end    
end
