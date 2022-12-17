FROM azul/zulu-openjdk-centos:19
MAINTAINER Bard Lind <bard.lind@gmail.com>
RUN yum -y install yum-cron
RUN yum -y update
RUN yum -y install curl

# Install Application
RUN adduser IotFrontend
ADD target/IotFrontend*.jar /home/IotFrontend/IotFrontend.jar"
ADD docker/IotFrontend.yml /home/IotFrontend/IotFrontend.yml
RUN chown IotFrontend:IotFrontend /home/IotFrontend/IotFrontend.yml
ADD docker/IotFrontend_override.properties /home/IotFrontend/IotFrontend-override.properties
RUN chown IotFrontend:IotFrontend /home/IotFrontend/IotFrontend.properties

EXPOSE 21500:21599

WORKDIR "/home/IotFrontend"
CMD [ \
    "java", \
    "-Xdebug", \
    "-Xrunjdwp:transport=dt_socket,address=21515,server=y,suspend=n", \
    "-Dcom.sun.management.jmxremote.port=21516", \
    "-Dcom.sun.management.jmxremote.rmi.port=21516", \
    "-Dcom.sun.management.jmxremote.ssl=false", \
    "-Dcom.sun.management.jmxremote.local.only=false", \
    "-Dcom.sun.management.jmxremote.authenticate=false", \
    "-Djava.rmi.server.hostname=localhost", \
    "-jar", \
    "IotFrontend.jar" \
]
