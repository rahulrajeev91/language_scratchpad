a = [1,2,3,4,5]

print "item\tprior result\n"

sum = a.inject(0) do |result, item|
  print item, "\t", result, "\n"
  result+Float(item)/2
end

print "sum: ", sum, "\n"
