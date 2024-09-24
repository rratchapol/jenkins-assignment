FROM node:20-alpine

# ติดตั้ง Python และ pip
RUN apk add --no-cache python3 py3-pip

WORKDIR /app

COPY . .

RUN npm install
RUN pip3 install robotframework  # ใช้ pip3 สำหรับ Python 3
CMD ["npm", "start"]

EXPOSE 3001