require_relative './lib/basic_runner'

def double(x)
    x * 2
end

tahini = Runner.new()

pp tahini.to_eq(4){ double(2) }

# need to find a way to specify tahinin files for testing. 
# Need a way to create contexts