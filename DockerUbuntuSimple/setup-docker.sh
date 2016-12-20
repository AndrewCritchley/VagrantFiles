sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates

echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" | sudo tee /etc/apt/sources.list.d/docker.list

sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

sudo apt-get update

sudo apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual -y

sudo apt-get install docker-engine -y