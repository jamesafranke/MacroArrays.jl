module MacroArrays

using Zarr
using NCDatasets
using Dates
using DataFrames
using Chain
using UnicodePlots
using MacroTools
#using Dagger
#using Unitful

include(joinpath("constructors", "constructors.jl"))
include(joinpath("functions", "io.jl"))
include(joinpath("functions", "manipulate.jl"))

export MacroArray,
     @zread, @nread, @nreadmany, @tozarr,
     @Aselect, @Aselect!, 
     @Asubset, @Asubset!,
     @Atransform, @Atransform!, 
     @Aby, @Aby!, 
     @Aresample, @Aresample!

end

