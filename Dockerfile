FROM openjdk:latest
RUN curl -sL https://rpm.nodesource.com/setup_12.x | bash - \
  && yum install -y nodejs
COPY package.json /app
RUN npm install
COPY . /app
CMD node app.js
EXPOSE 3000
