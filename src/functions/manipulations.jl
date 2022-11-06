## Array Manipulations

"""
    @with allows vars and dims to be called as symbols

"""
function exec(df, p::Pair)
    cols = first(p)
    fun = last(p)
    fun(map(c -> DataFramesMeta.getsinglecolumn(df, c), cols)...)
end
exec(df, s::Union{Symbol, AbstractString}) = df[!, s]

getsinglecolumn(df, s::DataFrames.ColumnIndex) = df[!, s]
getsinglecolumn(df, s) = throw(ArgumentError("Only indexing with Symbols, strings and integers " *
    "is currently allowed with $DOLLAR"))

function with_helper(d, body)
    # Make body an expression to force the
    # complicated method of fun_to_vec
    # in the case of QuoteNode
    t = fun_to_vec(Expr(:block, body); no_dest=true)
    :(DataFramesMeta.exec($d, $t))
end

macro with(d, body)
    esc(with_helper(d, body))
end

"""
    @Aselect filepath::String key::key
macro to select cetain vars from the dataset based on key
# Examples
```julia-repl

A = @Aselect A :pr :tas 
```
"""

macro Aselect(A::MacroArray, key::key, kwargs...)
    new = A[]
    return new
end 

"""
    @Aselect! filepath::String key::key
in place operation, see @Aselect
"""

macro Aselect!()

    return nothing
end

"""
    @Asubset filepath::String condition
macro to select cetain vars from the dataset based on key
# Examples
```julia-repl

A = @Asubset A :pr .>  0.001 
#or
A = @Asubset A :month .== 12
```
"""
function subset_helper(x, args...)
    x, exprs, outer_flags, kw = get_df_args_kwargs(x, args...; wrap_byrow = false)

    t = (fun_to_vec(ex; no_dest=true, outer_flags=outer_flags) for ex in exprs)
    quote
        $subset($x, $(t...); (skipmissing = true,)..., $(kw...))
    end
end

function where_helper(x, args...)
    x, exprs, outer_flags, kw = get_df_args_kwargs(x, args...; wrap_byrow = false)
    t = (fun_to_vec(ex; no_dest=true, outer_flags=outer_flags) for ex in exprs)
    quote
        $subset($x, $(t...); skipmissing=true, $(kw...))
    end
end


macro Asubset(x, args...)
    esc(subset_helper(x, args...))
end

function rsubset_helper(x, args...)
    x, exprs, outer_flags, kw = get_df_args_kwargs(x, args...; wrap_byrow = true)

    t = (fun_to_vec(ex; no_dest=true, outer_flags=outer_flags) for ex in exprs)
    quote
        $subset($x, $(t...); (skipmissing = true,)..., $(kw...))
    end
end


macro Atransform()

end 

macro Atransform!()

    return nothing
end

macro Aby()

end 

macro Aby!()

    return nothing
end

macro Aresample()

end 

macro Aresample!()

    return nothing
end


macro toDataFrame(A::MacroArray)

    return A
end
