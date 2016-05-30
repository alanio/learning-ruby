puts (1..500)
	.select{|n| n.odd? && (n%3==0)}
	.reduce(0){|buffer, n| buffer + n}