# MacroArrays

Julia package for high-level loading and manipulating multidimensional labeled arrays. Mostly designed for working with Earth System data cubes...but should hopefully be extensible to other scientific fields.

The package essentially tries to combine the functionality of the python package [xarray](https://docs.xarray.dev/en/stable/) with the reduction/transformation macros from [DataFramesMeta.jl](https://juliadata.github.io/DataFramesMeta.jl/stable/). In contrast to [AxisArrays.jl](https://github.com/JuliaArrays/AxisArrays.jl) and [YAXArrays.jl](https://github.com/JuliaDataCubes/YAXArrays.jl), this package focuses on loading **existing** data cubes (preferably on the cloud) and getting to training/analysis stacks as cleanly as possible with the use of macros and [Chain.jl](https://github.com/jkrumbiegel/Chain.jl).

Current support for zarr and NetCDFs files. Macro naming mirror DataFramesMeta.jl with a preceding A e.g. @subset => @Asubset.

### Planned extensions:
* support for common satellite data types
* integrate support for [Dagger.jl](https://github.com/JuliaParallel/Dagger.jl) for *out-of-core* operations
* [Unitful.jl](https://github.com/PainterQubits/Unitful.jl) integration

## Installation

You can install MacroArrays by typing in the repl:

```
] add MacroArrays
```

## Usage example

...for getting publicly-available [CMIP6](https://console.cloud.google.com/marketplace/details/noaa-public/cmip6?_ga=2.136097265.-1784288694.1541379221&project=e-context-252517) climate model data on google cloud

```julia

using MacroArrays

A = @zread "gs://cmip6/CMIP6/ScenarioMIP/NOAA-GFDL/GFDL-CM4/ssp585/r1i1p1f1/day/pr/gr1/v20180701/"

```

...perform some simple operations. For example, get monthly precipitation anomalies

```julia

A_anom = @chain A begin
  @Aselect :pr        #only necessary if you have multiple vars in the dataset
  @Atransform :month = Month.(:time)
  @Aby :month :monthly_mean = mean.(:pr)
  @Atransform :month_ano = :pr .- :monthly_mean
end

```

...or subset and reduce the data

```julia

A_reduced = @chain A begin
  @Atransform :month = Month.(:time)
  @Arsubset :month in Set([1,2,3])
  @Asubset :lat.<45 :lon.<10
end

```

...pipe to training device. Should convert to ::cuArray ok.

```julia
using CUDA, Flux
...
A_anom |> gpu

```

... in place operators

```julia
@Arsubset! A :lon in Set(30:0.5:80)
```
