## Array Manipulations

"""
    @Aselect(filepath::String, key::key,)
macro to select cetain vars from the dataset based on key
# Examples
```julia-repl

A = @Aselect A :pr :tas 
```
"""

macro @Aselect(A::MacroArray, key::key, kwargs...)
    new = A[]
    return new
end 

"""
    @Aselect!(filepath::String, key::key,)
in place operation, see @Aselect
"""

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