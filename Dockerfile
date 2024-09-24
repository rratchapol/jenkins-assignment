FROM node:20-alpine

# ติดตั้ง Python3, pip และ virtualenv
RUN apk add --no-cache python3 py3-pip py3-virtualenv

# สร้าง virtual environment
RUN python3 -m venv /venv

# ใช้ virtual environment
ENV PATH="/venv/bin:$PATH"

WORKDIR /app

COPY . .

# ติดตั้ง npm packages
RUN npm install

# ติดตั้ง robotframework ภายใน virtual environment
RUN pip install robotframework

CMD ["npm", "start"]

EXPOSE 3001
