FROM openjdk:8-jdk-alpine

ENV NAME mobile-web
ENV JAR_PATH mobile-web/build/libs

ARG VERSION

WORKDIR /app

COPY ${JAR_PATH}/${NAME}*.jar /app
COPY run.sh /app

RUN chmod a+x /app/run.sh

EXPOSE 8080

ENTRYPOINT /app/run.sh