FROM node:24-alpine

WORKDIR /app

COPY src/package.json .
COPY src/package-lock.json .

RUN npm install

COPY src/ .

EXPOSE 3000

CMD [ "npm", "start" ]
