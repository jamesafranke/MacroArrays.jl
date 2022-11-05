module MacroArrays
    using Zarr
    using NetCDF
    using Dates
    using DataFrames
    using Chain
    using Unitful
    using UnicodePlots
    #optional using CUDA
    #using Dagger

    mutable struct MacroArray
        lat::Float64
        lon::Float64
        pressure::Float64
        time::DateTime
        values::Float32
        valuesb::Float64
    end

    function displayshape(A::MacroArray)
        x = A[:,1,1]
        y = A[1,:,1]
        z = A[1,1,:]
        UnicodePlots.plot( axis = false, axistype=1)
    end

    macro @readz(filepath)
        A = zopen( filepath, consolidated=true )
        displayshape(A)
        return A::MacroArray
    end

    macro @readn(filepath) 
        A = ncread( filepath )
        displayshape(A)
        return A::MacroArray
    end

    #Array Manipulations
    macro @Aselect(A::MacroArray)
        new = A[]
        return new
    end 

    macro @Aselect!

        return nothing
    end

    macro @Asubset
    
    end 

    macro @Asubset!

        return nothing
    end

    macro @Atransform
    
    end 

    macro @Atransform!

        return nothing
    end

    macro @Aby
    
    end 

    macro @Aby!

        return nothing
    end

    macro @Aresample
    
    end 

    macro @Aresample!

        return nothing
    end


end

