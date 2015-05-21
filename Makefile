all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""  This is merely a base image for usage read the README file
	@echo ""   1. make run       - build and run docker container

build: builddocker beep

run: builddocker runpostgres rundocker beep

rundocker:
	@docker run --name=redminit \
	-d \
	--link=postgresql-redmine:postgresql --publish=10083:80 \
	--env='REDMINE_PORT=10083' \
	--volume=/srv/docker/redmine/redmine:/home/redmine/data \
	--volume=/tmp:/tmp \
	--cidfile="cid" \
	-v /tmp:/tmp \
	-v /var/run/docker.sock:/run/docker.sock \
	-v $(shell which docker):/bin/docker \
	sameersbn/redmine:2.6-latest

# used to be last line above --> 	-t joshuacox/redminit

runpostgres:
	docker run --name=postgresql-redmine -d \
	--env='DB_NAME=redmine_production' \
	--cidfile="postgrescid" \
	--env='DB_USER=redmine' --env='DB_PASS=password' \
	--volume=/tmp:/tmp \
	--volume=/srv/docker/redmine/postgresql:/var/lib/postgresql \
	sameersbn/postgresql:9.4

builddocker:
	/usr/bin/time -v docker build -t joshuacox/redminit .

beep:
	@echo "beep"
	@aplay /usr/share/sounds/alsa/Front_Center.wav

kill:
	@docker kill `cat cid`
	@docker kill `cat postgrescid`

rm-name:
	rm  name

rm-image:
	@docker rm `cat cid`
	@docker rm `cat postgrescid`
	@rm cid
	@rm postgrescid

rm: kill rm-image

clean: rm-name rm

enter:
	docker exec -i -t `cat cid` /bin/bash
