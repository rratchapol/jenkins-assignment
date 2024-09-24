FROM node:20-alpine

# ติดตั้ง Python3 และ pip
RUN apk add --no-cache python3 py3-pip

WORKDIR /app

COPY . .

RUN npm install
RUN pip3 install robotframework  
CMD ["npm", "start"]

EXPOSE 3001
