FROM centos:7

MAINTAINER Robert de Bock

LABEL Description="Base RUNDECK image" Version="2.7.3"

# Settings you will need to change for your setup.
ENV HOSTNAME localhost
ENV URL https://localhost

# These variables -may- be adjusted to your liking.
ENV PORT 4440
ENV MYSQL_HOST mysql
ENV MYSQL_DATABASE rundeck
ENV MYSQL_USER rundeck
ENV MYSQL_PASSWORD rundeck

VOLUME /var/log/rundeck
VOLUME /var/rundeck
VOLUME /var/lib/rundeck/var/storage
VOLUME /var/lib/rundeck/logs

RUN rpm -Uvh http://repo.rundeck.org/latest.rpm
RUN yum -y install java-1.8.0-openjdk \
                   openssh-clients \ 
                   rundeck && \
    yum -y clean all

CMD  while ! exec 6<>/dev/tcp/${MYSQL_HOST}/3306 ; do echo "$(date) - still trying to connect to MySQL at ${MYSQL_HOST}" ; sleep 1 ; done && \
    sed -i '/dataSource.url/d' /etc/rundeck/rundeck-config.properties && \
    echo "dataSource.url = jdbc:mysql://${MYSQL_HOST}/${MYSQL_DATABASE}?autoReconnect=true" >> /etc/rundeck/rundeck-config.properties && \
    echo "dataSource.username=${MYSQL_USER}" >> /etc/rundeck/rundeck-config.properties && \
    echo "dataSource.password=${MYSQL_PASSWORD}" >> /etc/rundeck/rundeck-config.properties && \
    echo "grails.serverURL=${URL}" >> /etc/rundeck/rundeck-config.properties && \
    sed -i '/framework.ssh.timeout/d' /etc/rundeck/framework.properties && \
    echo "framework.ssh.timeout = 60000" >> /etc/rundeck/framework.properties && \
    source /etc/rundeck/profile && \
    ${JAVA_HOME:-/usr}/bin/java ${RDECK_JVM} -Xmx4096m -Xms1024m -Drundeck.jetty.connector.forwarded=true -cp ${BOOTSTRAP_CP} com.dtolabs.rundeck.RunServer /var/lib/rundeck ${RDECK_HTTP_PORT}

EXPOSE 4440
