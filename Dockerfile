# Build stage
FROM maven:3.9.3-jdk-11-slim AS build
LABEL stage=builder
WORKDIR /app

# Copy pom dan source code
COPY pom.xml .
COPY src ./src

# Build WAR
RUN mvn -B package -DskipTests

# Runtime stage
FROM tomcat:9.0-jdk11-openjdk-slim
LABEL maintainer="rbook"

# Copy WAR hasil build ke Tomcat webapps sebagai ROOT.war
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Buat uploads directory untuk persistent volume (Railway)
RUN mkdir -p /usr/local/tomcat/uploads && chown -R 1000:1000 /usr/local/tomcat/uploads
ENV UPLOAD_DIR=/usr/local/tomcat/uploads

EXPOSE 8080
CMD ["catalina.sh", "run"]
