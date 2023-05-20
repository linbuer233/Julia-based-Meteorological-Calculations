using Unitful

function degC2K(T)
    if unit(T)!=u"K"
        return uconvert(u"K",T)
    end
    return T
end

function K2degC(T)
    if unit(T)!=u"°C"
        temp=uconvert(u"°C",T)
        return convert(Float64,temp.val)*unit(temp)
    end 
    return T
end