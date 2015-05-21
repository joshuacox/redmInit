FROM sameersbn/redmine:2.6-latest
MAINTAINER Josh Cox <josh 'at' webhosting coop>

ENV REDMINIT_UPDATED 20150513

EXPOSE 80
EXPOSE 443

VOLUME ["/home/redmine/data"]
VOLUME ["/var/log/redmine"]

WORKDIR /home/redmine/redmine
ENTRYPOINT ["/app/init"]
CMD ["app:start"]
