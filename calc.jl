module calc
    # 大气压强
    # https://latex.codecogs.com/svg.image?&space;P=P_0e^{-\frac{Mgh}{RT}}
    function atmospheric_pressure(P0, M, g, h, R, T)
        return P0 * exp(-M*g*h/(R*T))
    end
    # 计算相对湿度 
    function relative_humidity(temp, dew_temp) # 单位为摄氏度 
        es = 6.112 * exp(17.269 .*(temp + 273.16) ./ (temp - 35.86)) # 饱和水汽压力
        e = 6.112 * exp(17.269 .*(dew_temp + 273.16) ./ (dew_temp - 35.86)) # 实际水汽压力
        rh = e ./ es * 100 # 相对湿度
        return rh
    end    
end
