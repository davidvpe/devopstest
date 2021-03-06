FROM node:8.1.3

EXPOSE 3000

WORKDIR /app

ADD package.json /app/

RUN yarn install

ADD . /app

CMD ["node", "server"]

