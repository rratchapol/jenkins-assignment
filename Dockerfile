FROM node:20-alpine

WORKDIR /app

COPY . .

RUN npm install
RUN pip install robotframework
CMD ["npm","start"]

EXPOSE 3001