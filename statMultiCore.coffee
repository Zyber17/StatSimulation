cluster = require 'cluster'
i = 0
n = 0
cn = []
ci = []
val = []

if cluster.isMaster
	cpus = require('os').cpus().length

	for cpu in [2...cpus] # Not 0...cpus, leave at least one 'core' open for work.
		cluster.fork()

	cluster.on 'exit', (worker) ->
		# Replace the dead worker, we're not sentimental
		console.log "Worker #{worker.id} died :("
		cluster.fork()

	messageHandler = (msg) ->
		if msg.i then i+=msg.i
		if msg.n then n+=msg.n

		#process.stdout.write "#{i}"

		if i % 100000000 == 0
			process.stdout.write "iterations: #{i/1000000} million,	average: #{i/n}\n"

	Object.keys(cluster.workers).forEach (id) ->
 	   cluster.workers[id].on 'message', messageHandler


else if cluster.isWorker
	wid = cluster.worker.process.pid

	cn[wid] = 0
	ci[wid] = 0
	val[wid] = []
	while true
		val[wid][Math.floor(Math.random()*6)] = true
		if val[wid][1] == true && val[wid][2] == true && val[wid][3] == true && val[wid][4] == true && val[wid][5] == true && val[wid][0] == true

			val[wid] = []
			cn[wid]++

		ci[wid]++


		if ci[wid] % 100000000 == 0
			process.send
				i: ci[wid]
				n: cn[wid]

			cn[wid] = 0
			ci[wid] = 0
