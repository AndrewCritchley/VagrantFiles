# The first item in the swarm will be the primary manager.
#   the rest will all be secondary managers

if [ $1 -eq 1 ]; then

    docker run --restart=unless-stopped -d -h consul1 --name consul1 -v /mnt:/data \
    -p 10.0.1.5:8300:8300 \
    -p 10.0.1.5:8301:8301 \
    -p 10.0.1.5:8301:8301/udp \
    -p 10.0.1.5:8302:8302 \
    -p 10.0.1.5:8302:8302/udp \
    -p 10.0.1.5:8400:8400 \
    -p 10.0.1.5:8500:8500 \
    -p 172.17.0.1:53:53/udp \
    progrium/consul -server -advertise 10.0.1.5 -bootstrap-expect 2

else

    docker run --restart=unless-stopped -d -h "consul$1" --name "consul$1" -v /mnt:/data  \
    -p 10.0.$1.5:8300:8300 \
    -p 10.0.$1.5:8301:8301 \
    -p 10.0.$1.5:8301:8301/udp \
    -p 10.0.$1.5:8302:8302 \
    -p 10.0.$1.5:8302:8302/udp \
    -p 10.0.$1.5:8400:8400 \
    -p 10.0.$1.5:8500:8500 \
    -p 172.17.0.1:53:53/udp \
    progrium/consul -server -advertise "10.0.$1.5" -join 10.0.1.5

fi

docker run --restart=unless-stopped -h "mgr$1" --name "mgr$1" -d -p 3375:2375 swarm manage --replication --advertise 10.0.$1.5:3375 consul://10.0.$1.5:8500/

# Launch a local registrator service to register swarm as a service with consul
docker run -d --name registrator -h registrator -v /var/run/docker.sock:/tmp/docker.sock gliderlabs/registrator:latest consul://10.0.1.5:8500