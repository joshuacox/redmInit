# redmInit
Initialize a redmine installation including database and dump it all to /tmp ready to be used as a skeleton redmine backup just after initialization.  I'm using this to initialize an export directory to be used with Docker and Octohost. YMMV

ignore the Dockerfile for now, I was using it for some experimentation

## Usage
`make run` and you should have three containers running at this point I’ve been going in toying with it a bit then I backup the databases and the data folder for redmine, thow it all away then stick it up in the cloud
