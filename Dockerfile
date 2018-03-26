FROM node:8.1.3

EXPOSE 8081

#install babel-cli
RUN npm install -g babel-cli

WORKDIR /app

ADD package.json /app/

RUN npm install

ADD . /app

RUN babel -d /app/build/ /app/server/ -s

CMD ["node", "build/index.js"]

