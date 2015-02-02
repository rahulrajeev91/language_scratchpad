Ruby Learnings
==============

Array Injection
---------------
A simple way to do aggregation style processes on an array

### Example code:
```ruby
a = [1,2,3,4,5]

print "item\tprior result\n"

sum = a.inject(0) do |result, item|
  print item, "\t", result, "\n"
  result+Float(item)/2
end

print "sum: ", sum, "\n"
```
result:
```sh
$ ruby inject.rb
item    prior result
1       0
2       0.5
3       1.5
4       3.0
5       5.0

sum: 7.5
```
### Gotcha:
If the initial result is not passed in, the inject opperator just uses the first item in the list as the result and starts the iteration from the second item. This may lead to a different result than expected.

```ruby
sum = a.inject do |result, item|
  print item, "\t", result, "\n"
  result+Float(item)/2
end
```
result:
```sh
$ ruby inject.rb
item    prior result
2       1
3       2.0
4       3.5
5       5.5

sum: 8.0
```

Code blocks
-----------

### Opening a file

Code blocks let us write something like this.
```
File.open("foo.txt","w") { |f| f << "This is sexy" }
```

Instead of forcing us to write this:
```
file = File.open("foo.txt","w")
file << "This is tedious"
file.close
```
The code blocks help close the file after the write is done, much like Python.

Hashes
------
### Default values
A hash that creates an item that does not exist by default - using Code Blocks, and ruby magic
```
h = Hash.new { |hash, key| hash[key] = "Go Fish: #{key}" } #=> {}
h["10"] #=> "Go fish: 10"
```

### Arrays
Converting to array:
```
h = {"a" => 10, "b" => 20}
h.flatten
# => ["a", 10, "b", 20]
h.values
# => [10, 20]
h.collect {|k, v| [k,v]}
# => [["a", 10], ["b", 20]]
```

Converting array to Hash
```
a = [1,2,3,4,5]
Hash[a.collect{|a| [a, a*2]}]
# => {1=>2, 2=>4, 3=>6, 4=>8, 5=>10}
```
