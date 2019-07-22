all: build

build:
	sudo docker build --shm-size 2g -t cyrinux/jok3r-slim:latest docker/

distclean: clean

clean:
	sudo docker rmi -f cyrinux/jok3r-slim:latest

push:
	sudo docker push cyrinux/jok3r-slim:latest

run:
	sudo docker run --rm -t -i --name jok3r-slim -e DISPLAY=:0 -v /tmp/.X11-unix:/tmp/.X11-unix --shm-size 2g --net=host -p 8443 cyrinux/jok3r-slim:latest

shell:
	sudo docker start jok3r-slim
	sudo docker exec -t -i jok3r-slim /bin/bash
