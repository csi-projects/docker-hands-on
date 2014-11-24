FROM ubuntu:14.04

COPY jdk-7u71-linux-x64.gz .
RUN tar -zxvf jdk-7u71-linux-x64.gz; mkdir /usr/lib/java; mv jdk1.7.0_71 /usr/lib/java
ENV JAVA_HOME /usr/lib/java/jdk1.7.0_71

COPY apache-tomcat-7.0.57.tar.gz .
RUN tar -zxvf apache-tomcat-7.0.57.tar.gz; mkdir /usr/lib/tomcat; mv apache-tomcat-7.0.57 /usr/lib/tomcat
EXPOSE 8080
VOLUME ["/usr/lib/tomcat/apache-tomcat-7.0.57/logs"]

ADD handson.war .
RUN cp handson.war /usr/lib/tomcat/apache-tomcat-7.0.57/webapps

CMD /usr/lib/tomcat/apache-tomcat-7.0.57/bin/catalina.sh run