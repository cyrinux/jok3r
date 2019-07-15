all: build

build:
	sudo docker build --shm-size 2g -t cyrinux/jok3r:latest docker/

distclean: clean

clean:
	sudo docker rmi -f cyrinux/jok3r:latest

push:
	sudo docker push cyrinux/jok3r:latest

run:
	sudo docker run -t -i --name jok3r-archlinux -e DISPLAY=:0 -v /tmp/.X11-unix:/tmp/.X11-unix --shm-size 2g --net=host cyrinux/jok3r:latest
