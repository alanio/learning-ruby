numbers = [1,2,3,4,5,6]

double = []

numbers.each do |number|
	double << number*2
end

p double

#usando map
#p numbers.map{|number| number * 2}

#p numbers.map{|number| number * 2 if number > 3}.compact

p numbers
	.select{|n| n > 3}
	.map{|number| number * 2 }

puts "============"
#somando
soma = 0;
numbers.map{|number| soma += number}
puts soma