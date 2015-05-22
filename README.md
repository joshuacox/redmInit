# redmInit
Initialize a redmine installation including database and dump it all to /tmp ready to be used as a skeleton redmine backup just after initialization.  I'm using this to initialize an export directory to be used with Docker and Octohost. YMMV

ignore the Dockerfile for now, I was using it for some experimentation

## Usage
`make run` 

Assuming you did this locally, you should have three containers running at this point login to the redmine one here:

http://127.0.0.1:10083

user: admin pass: admin

I’ve been going in toying with it a bit get it where I want it
you can make a plugins directory and install them here

`/srv/docker/redmine/redmine/plugins/`

then I backup the databases and the data folder for redmine,
thow it all away then stick it up in the cloud

## Redis
I added the redis container to support this plugin:
https://github.com/ogom/redmine_sidekiq
