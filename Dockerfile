FROM node:14-slim
EXPOSE 8081
COPY app.js .
CMD node app.js