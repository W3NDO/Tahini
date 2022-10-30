# Tahini
This is a basic test runner for ruby. Follows syntax similar to RSpec for the most part. 

## The Tahini Class
This is the main class that actually runs the tests. 

It has specific methods defined to help with testing.

### Tahini#test
This is the main block for testig a specific class. It is the equivalent of `RSpec.describe Class ...` This is where execution starts

```
Tahini.test(ClassName) do
...
end
```

It will run all the tests defined within it's block.

### Tahini#context
This is a block that provides a context for the tests. Similar to RSpec's scenarios or describe. 

### Tahini#it
Should be used to specify a specific set of tests. 

### Tahini#to_eq and Tahini#to_be
Does the actual equality comparisons. 

- The `to_eq` will compare the passed block against a boolean, string, number, or array that you pass in the arguments. Hashes do not work for now and i am not sure why.
```
Runner.to_eq(expected_value) do
				# block that results in actual value
end
```

- the `to_be` function will compare against a passed boolean. any block you pass should result in a boolean value
```
Runner.to_be(boolean) do
				# block to return boolean
end
```
