all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""  This is merely a base image for usage read the README file
	@echo ""   1. make run       - build and run docker container

build: builddocker beep

run: runpostgres runredminit beep

runbuild: builddocker runpostgres runredis runredminit beep

runredis:
	docker run --name some-redis \
	-d \
	--cidfile="redisCID" \
	--volume=/srv/docker/redis/data:/data \
	redis \
	redis-server --appendonly yes

runredminit:
	docker run --name=redminit \
	-d \
	--link=postgresql-redmine:postgresql --publish=10083:80 \
	--link= some-redis:redis \
	--env='REDMINE_PORT=10083' \
	--volume=/srv/docker/redmine/redmine:/home/redmine/data \
	--volume=/tmp:/tmp \
	--cidfile="redminitCID" \
	sameersbn/redmine

#	sameersbn/redmine:2.6-latest

# used to be last line above --> 	-t joshuacox/redminit

runpostgres:
	docker run --name=postgresql-redmine -d \
	--env='DB_NAME=redmine_production' \
	--cidfile="postgresCID" \
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
	@docker kill `cat redminitCID`
	@docker kill `cat postgresCID`
	@docker kill `cat redisCID`

rm-name:
	rm  name

rm-image:
	@docker rm `cat redminitCID`
	@docker rm `cat postgresCID`
	@docker rm `cat redisCID`

rm-cids:
	@rm redminitCID
	@rm postgresCID
	@rm redisCID

rm: kill rm-image rm-cids

clean: rm-name rm

enter:
	docker exec -i -t `cat redminitCID` /bin/bash

pgenter:
	docker exec -i -t `cat postgresCID` /bin/bash
