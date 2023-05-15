module unitsconvert
    export K2degC,degC2K

    function K2degC(Tk)
            return Tk.v-273.15
    end
    function degC2K(Tk)
        return Tk.v+273.15
        
end
end