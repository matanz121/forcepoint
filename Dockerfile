FROM node:12
RUN apt-get update && apt-get install -y openjdk-8-jdk
WORKDIR /app
RUN npm init -y
RUN npm install
CMD node app.js
EXPOSE 3000