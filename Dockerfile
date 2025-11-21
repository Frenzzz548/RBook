FROM tomcat:9-jdk11-openjdk
LABEL maintainer="rbook"

# copy built WAR into Tomcat
ARG WAR_FILE=target/rbook.war
COPY ${WAR_FILE} /usr/local/tomcat/webapps/ROOT.war

# create uploads directory (Railway will mount a persistent volume here)
# NOTE: Railway disallows the VOLUME instruction in Dockerfiles. Do NOT add `VOLUME`.
# Instead, in the Railway project settings create a Volume and mount it to
# `/usr/local/tomcat/uploads` so uploaded images persist across deploys.
RUN mkdir -p /usr/local/tomcat/uploads && chown -R 1000:1000 /usr/local/tomcat/uploads

ENV UPLOAD_DIR=/usr/local/tomcat/uploads

EXPOSE 8080
CMD ["catalina.sh", "run"]
