docker run --restart=unless-stopped -d -h consul-agt$1 --name consul-agt$1 \
	-p 8300:8300 \
	-p 8301:8301 -p 8301:8301/udp \
	-p 8302:8302 -p 8302:8302/udp \
	-p 8400:8400 \
	-p 8500:8500 \
	-p 8600:8600/udp \
	progrium/consul -rejoin -advertise 10.0.$1.5 -join 10.0.1.5	

# Launch a local registrator service to register swarm as a service with consul
docker run -d --name registrator -h registrator -v /var/run/docker.sock:/tmp/docker.sock gliderlabs/registrator:latest consul://10.0.1.5:8500