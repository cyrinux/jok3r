all: build

build:
	sudo docker build --shm-size 2g -t cyrinux/jok3r-slim:latest docker/

distclean: clean

clean:
	sudo docker rmi -f cyrinux/jok3r-sliù:latest

push:
	sudo docker push cyrinux/jok3r-slim:latest

run:
	sudo docker run -t -i --name jok3r-slim -e DISPLAY=:0 -v /tmp/.X11-unix:/tmp/.X11-unix --shm-size 2g --net=host cyrinux/jok3r-slim:latest
