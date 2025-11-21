FROM maven:3.8.8-openjdk-11 AS build
LABEL stage=builder
WORKDIR /app

# copy pom first to leverage Docker cache for dependencies
COPY pom.xml .
COPY src ./src

# build the WAR inside the builder image
RUN mvn -B package -DskipTests

FROM tomcat:9-jdk11-openjdk
LABEL maintainer="rbook"

# Copy WAR from build stage into Tomcat webapps as ROOT.war
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# create uploads directory (Railway will mount a persistent volume here)
# NOTE: Railway disallows the VOLUME instruction in Dockerfiles. Do NOT add `VOLUME`.
# Instead, in the Railway project settings create a Volume and mount it to
# `/usr/local/tomcat/uploads` so uploaded images persist across deploys.
RUN mkdir -p /usr/local/tomcat/uploads && chown -R 1000:1000 /usr/local/tomcat/uploads

ENV UPLOAD_DIR=/usr/local/tomcat/uploads

EXPOSE 8080
CMD ["catalina.sh", "run"]
