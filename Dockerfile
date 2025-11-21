FROM tomcat:9-jdk11-openjdk
LABEL maintainer="rbook"

# copy built WAR into Tomcat
ARG WAR_FILE=target/rbook.war
COPY ${WAR_FILE} /usr/local/tomcat/webapps/ROOT.war

# create uploads directory
RUN mkdir -p /usr/local/tomcat/uploads
VOLUME ["/usr/local/tomcat/uploads"]

ENV UPLOAD_DIR=/usr/local/tomcat/uploads

EXPOSE 8080
CMD ["catalina.sh", "run"]
