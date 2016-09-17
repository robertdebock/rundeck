[![](https://images.microbadger.com/badges/image/robertdebock/rundeck.svg)](http://microbadger.com/images/robertdebock/rundeck "Get your own image badge on microbadger.com")

# About this container.

[RUNDECK](http://rundeck.org/) is a (web) application to run commands on other hosts. It can be used to manage other (Linux) hosts.

RUNDECK about RUNDECK: Go Fast. Be Secure. Turn your operations procedures into self-service jobs. Safely give others the control and visibility they need.

This container will start an "empty" RUNDECK, but data can be saved, making the application persistent.

# Running this container.

To run this application, use:

    docker run \
    -p 4440:4440 \
    -e URL="http://192.168.1.2" \
    -e HOST="192.168.1.2" \
    -e MYSQL_DATABASE="rundeck" \
    -e MYSQL_HOST="mysql" \
    -e MYSQL_PASSWORD="rundeck" \
    -e MYSQL_USER="rundeck"
    -d \
    robertdebock/docker-rundeck

# Usage explained.
This are the meaning of the different options:

|option|default value|usage|
|---|---|---|
|-p|4440|Any (TCP) port, you may want to map an external port to this local port using: "external:internal". (i.e. "8080:4440")|
|-e HOST|localhost|A host where the API can be found.|
|-e URL|http://localhost:4440|A URL where RUNDECK will be presented.|
|-e MYSQL_HOST|mysql|A host where MySQL can be found, the hostname or IP-address.|
|-e MYSQL_DATABASE|rundeck|The name of the MySQL database.|
|-e MYSQL_USER|rundeck|A user to connect to the database.|
|-e MYSQL_PASSWORD|rundeck|A password for the user to connect to the database.|
|-d|n.a.|Detach to the background.|
|robertdebock/docker-rundeck|n.a.|Refers to this container.|

This container works well with docker-compose: https://github.com/robertdebock/docker-compose-rundeck

# Persistent data.
Data in rundeck is saved to two locations:

- MySQL - The jobs and job history
- /var/log/rundeck - The logs for RUNDECK. Not required to be able to stop/start this container without loosing jobs.
- /var/rundeck - The projects and it's configurations are stored here, so required to stop/start this container without losing project details.
- /var/lib/rundeck/var/storage - The keystore is stored here.
- /var/lib/rundeck/logs - The logs are stored.

# Bastion hosts in RUNDECK.
RUNDECK has no built-in facility to manage hosts available behind a bastion-host. This Docker container contains an SSH client for this. Here is a way to work with these kind of hosts, be sure to modify these lines.

## Change the project.properties.
The file /var/rundeck/projects/${project}/etc/project.properties needs a few changes:

    resources.source.1.config.format=resourceyaml
    resources.source.1.config.file=/var/rundeck/projects/${project}/etc/resources.yaml
    project.ssh-keypath=/var/rundeck/projects/${project}/.ssh/id_rsa

## Create a resources.yaml.

    ${destinationhost}:
      description: The server you'd like to manage in RUNDECK
      tags: '' 
      hostname: ${destinationhost}
      osArch: x86_64
      osFamily: unix
      osName: Linux
      osVersion: ''
      username: someusername
      node-executor: script-exec
      script-exec: /usr/bin/ssh -q -F /var/rundeck/projects/${project}/etc/ssh_config ${node.hostname} -- ${exec.command}

## Add ssh_config.

    Host *
      StrictHostKeyChecking no
      Port 1234
      User someusername
      ProxyCommand ssh -q -i /var/rundeck/projects/${project}/.ssh/id_rsa ${bastionhost} nc -w 180 %h %p
      IdentityFile /var/rundeck/projects/${project}/.ssh/id_dsa
