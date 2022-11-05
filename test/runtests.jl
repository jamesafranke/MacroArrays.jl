using MacroArrays
using Test

@testset "MacroArrays.jl" begin
    a = @readz "gs://cmip6/CMIP6/ScenarioMIP/NOAA-GFDL/GFDL-CM4/ssp585/r1i1p1f1/day/pr/gr1/v20180701/"
end
