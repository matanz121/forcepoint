FROM node:12
RUN apt-get update && apt-get install -y openjdk-8-jdk
RUN npm init -y
CMD node app.js
EXPOSE 3000