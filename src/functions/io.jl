#helper function to display dataset dims and vars in repl
function displayshape(A::MacroArray)
    x = A[:,1,1]
    y = A[1,:,1]
    z = A[1,1,:]
    UnicodePlots.plot( axis = false, axistype=1)
end

"""
    @zread(filepath::String)
Lazy read zarr in from store or folder
# Examples
```julia-repl
A = @zread "some-file-path"
```
"""
macro zread(filepath::String)
    A = zopen( filepath, consolidated=true )
    displayshape(A)
    return A::MacroArray
end

"""
    @nread(filepath::String)
Lazy read NetCDF
# Examples
```julia-repl
A = @nread "some-file-path"
```
"""

macro nread(filepath::String) 
    A = ncread( filepath )
    displayshape(A)
    return A::MacroArray
end

"""
    @nreadmany(list[filepath::String])
Lazy read a folder of netcdfs
# Examples
```julia-repl
A = @nreadmany "some-folder-path"
```
"""
macro nreadmany(filepath::String, concat_dim::Symbol=:time) 
    A = ncread( filepath )
    displayshape(A)
    return A::MacroArray
end

"""
    @tozarr(filepath::String)
save MacroArray object as zarr
# Examples
```julia-repl
@tozarr A "some-file-path"
```
"""
macro tozarr(A::MacroArray, filepath::String) 
    tozarr( filepath )
    return nothing
end