############################################
# TODO: 重写运算
############################################
include("./unitsComRule.jl")

module calc
    include("./unitsconvert.jl")
    using Unitful
    export e,q
    # 大气压强
    # https://latex.codecogs.com/svg.image?&space;P=P_0e^{-\frac{Mgh}{RT}}
    function atmospheric_pressure(P0::Quantity, M::Quantity, g::Quantity, h::Quantity, R::Quantity, T::Quantity)
        T=degC2K(T)
        aa=(-M .* g .* h ./ (R .*  T)) |> NoUnits
        return P0 .* exp(aa)
    end

    #############################湿度特征参量#############################
    # 水汽压
    # https://latex.codecogs.com/svg.image?&space;e=6.11\times10%20^{\frac{7.5\times%20t}{237.3\times%20t}}
    function e(temp::Quantity) # K
        # return 6.11 .* 10^((7.5 .* temp) ./ (237.3 .+ temp))
        return (6.112 .* exp(17.67 .* (temp - 273.15) ./ (temp-273.15 .+ 243.5)))u"hPa"
    end
    
    # 计算相对湿度 
    function relative_humidity(temp::Quantity, dew_temp::Quantity) # 单位为摄氏度 
        # temp=K2degC(temp)
        # dew_temp=K2degC(dew_temp)
        es = e(temp) # 饱和水汽压力
        en = e(dew_temp) # 实际水汽压力
        rh = en ./ es * 100 # 相对湿度
        return rh
    end
    function relative_humidity(temp::Quantity, dew_temp::Quantity) # 单位为摄氏度 
        es = e(temp) # 饱和水汽压力
        en = e(dew_temp) # 实际水汽压力
        rh = en ./ es * 100 # 相对湿度
        return rh
    end

    # 绝对湿度
    function absolute_humidity(temp::Quantity) 
        temp=degC2K(temp)
        return 0.217 .* e(temp) ./ temp *100
    end

    # 比湿 （饱和比湿）
    function q(temp::Quantity,P::Quantity)
        return (622 .* e(temp).val ./ (P.val .- 0.378 .* e(temp).val))u"g/kg"  # 单位(g/kg)
    end
    # 混合比
    function Wq(temp::Quantity,P::Quantity)
        return 622 .* e(temp) ./ (P .- e(temp))
    end
    #############################温度特征参量#############################
    # 位温
    function theta(temp::Quantity,P::Quantity,P0::Quantity)
        temp=degC2K(temp)
        return temp .* (P0 ./ P)^0.286 # K
    end
    # 绝对虚温 
    function temp_v_from_q(temp::Quantity,q1::Quantity) # q为(g/g)
        temp=degC2K(temp)
        q1=uconvert(u"g/g",q1)
        return (1 .+ 0.61 .* q1).*temp
    end
    function temp_v(temp::Quantity,P::Quantity)
        temp=degC2K(temp)
        q1=uconvert(u"g/g",q(temp,P))
        return (1 .+ 0.61 .* q1) .* temp
    end
end