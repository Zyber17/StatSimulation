i=1 # Number of iterations
val = []
n = 0 # Number of times all six numbers have been found
while true
	val[Math.floor(Math.random()*6)] = true
	if val[1] == true && val[2] == true && val[3] == true && val[4] == true && val[5] == true && val[0] == true
		val = []
		n++
	if i % 100000000 == 0
		process.stdout.write "iterations: #{i/1000000000} billion,	average: #{i/n}\n"
	i++