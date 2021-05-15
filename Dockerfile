FROM node:12
RUN apt-get update && apt-get install -y openjdk-8-jdk
EXPOSE 3000
