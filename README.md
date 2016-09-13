# rundeck
An environment to run RUNDECK.

There are 3 containers configured:
- httpd - Apache HTTPD, as a web frontend.
- rundeck - The application.
- mysql - The storage for jobs and job-history. This container will wait until MySQL is available.

To use this "environment" issue:

    git clone https://github.com/robertdebock/rundeck.git
    cd rundeck
    # Edit settings in variables.env to you liking.
    docker-compose build
    docker-compose up

This will create a "data" directory to store all persistent data.

When everything has been started (should take some 30 seconds) you can visit
the URL that you've specified in variables.env.

I've included a few scripts, mostly as a sample:
- add-to-resources.sh - A script to add hosts to rundeck's resources.xml.
- backup.sh - A script to make a backup of all data.
- restore.sh - A script to restore all data.
- list-projects.sh - A script using the API to list projects.
- list-jobs.sh - A script using the API to list jobs in a project.
- execute-jobs.sh - A script using the API to start jobs.

Interesting settings:
- The "web" service is the entrace to this application, and must be listening to a port, you may need to change "ports"
in docker-compose.yml
