module MacroArrays

using Zarr
using NetCDF
using Dates
using DataFrames
using Chain
using Unitful
using UnicodePlots
#using Dagger

include(joinpath("constructors", "constructors.jl"))
include(joinpath("functions", "load.jl"))
include(joinpath("functions", "manipulate.jl"))
export MacroArray, @zload, @nload, @Aselect, @Aselect!, @Asubset, @Asubset!, @Atransform, @Atransform!, @Aby, @Aby!, 

end

