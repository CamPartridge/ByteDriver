FROM node:16-slim

COPY . .

RUN npm install

ENV PORT=8080

EXPOSE 8080

CMD [ "npm", "start" ]