FROM ubuntu:14.04

ADD apache-tomcat-7.0.57.tar.gz .
ADD jdk-7u71-linux-x64.gz .
ADD handson.war .

RUN tar -zxvf jdk-7u71-linux-x64.gz; mkdir /usr/lib/java; mv jdk1.7.0_71 /usr/lib/java
ENV JAVA_HOME /usr/lib/java/jdk1.7.0_71

RUN tar -zxvf apache-tomcat-7.0.57.tar.gz; mkdir /usr/lib/tomcat; mv apache-tomcat-7.0.57 /usr/lib/tomcat

# RUN mv handson.war /usr/lib/tomcat/apache-tomcat-7.0.57/webapps

EXPOSE 8080

CMD /usr/lib/tomcat/apache-tomcat-7.0.57/bin/catalina.sh start