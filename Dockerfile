# Build stage
FROM maven:3.9.3-openjdk-11-slim AS build
LABEL stage=builder
WORKDIR /app

# copy pom first to leverage Docker cache for dependencies
COPY pom.xml . 
COPY src ./src

# build the WAR inside the builder image
RUN mvn -B package -DskipTests

# Runtime stage
FROM tomcat:9.0-jdk11-openjdk-slim
LABEL maintainer="rbook"

# Copy WAR dari build stage
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# buat uploads directory untuk persistent volume Railway
RUN mkdir -p /usr/local/tomcat/uploads && chown -R 1000:1000 /usr/local/tomcat/uploads
ENV UPLOAD_DIR=/usr/local/tomcat/uploads

EXPOSE 8080
CMD ["catalina.sh", "run"]
