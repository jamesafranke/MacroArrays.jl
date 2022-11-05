"""
mutable struct MacroArray
This is the main workhorse class dataset
# Fields
$(TYPEDFIELDS)
"""

mutable struct MacroArray
    lat::Float64
    lon::Float64
    pressure::Float64
    time::DateTime
    values::Float32
    valuesb::Float64
end
