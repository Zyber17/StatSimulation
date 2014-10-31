i=1
val = []
n = 0
while true
	val[Math.floor(Math.random()*6)] = true
	if val[1] == true && val[2] == true && val[3] == true && val[4] == true && val[5] == true && val[0] == true
		val = []
		n++
	if i % 10000000 == 0
		process.stdout.write "i: #{i},	average: #{i/n}\n"
	i++
