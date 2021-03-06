FROM node:12
RUN apt-get update && apt-get install -y openjdk-8-jdk
WORKDIR /app
COPY package.json /app
RUN npm install
COPY . /app
RUN npm run test
CMD node app.js
EXPOSE 3000