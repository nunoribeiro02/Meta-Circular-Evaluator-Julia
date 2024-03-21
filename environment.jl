include("primitives.jl")

# Frames -----------------------------------------------------------------------------
# ! provavelmente ja nao e preciso, REVER
# Constructor
make_frame(names, values) = (names, values)

# Selectors
frame_variables(frame) = frame[1]

frame_names(frame) = frame[2]

# Environment ------------------------------------------------------------------------
# ((name-0 . value-0) (name-1 . value-1) ... (name-n . value-n))

empty_environment() = Dict{Symbol, Any}()

# Constructor
function make_environment(name, value, env)
  env[name] = value
  
  return env
end

# Operations
function augment_environment(names, values, env)
  if isempty(names)
    return env
  else
    return augment_environment(names[2:end], values[2:end], make_environment(names[1], values[1], env))
  end
end

function initial_environment()
  names = [key for key in keys(initial_bindings())]
  valuess = [value for value in values(initial_bindings())]

  return augment_environment(names, valuess, empty_environment())
end