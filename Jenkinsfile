pipeline {
  agent {
    label 'vm2'
  }

  stages {
    stage('Clone') {
      steps {
        git branch: 'main', url: 'https://github.com/rratchapol/jenkins-assignment.git'
        sh 'whoami'
      }
    }
    stage('Install Packet') {
      steps {
        sh 'npm install'
      }
    }
    stage('Run Unittest') {
      steps {
        sh 'whoami'
        // เรียกใช้การทดสอบโดยไม่เริ่มเซิร์ฟเวอร์จริง
        sh 'npm test -- --runInBand --detectOpenHandles'
      }
    }
    stage('Run Robot') {
      steps {
        echo 'Create Container'
        sh 'docker compose -f ./docker-compose.dev.yaml up -d --build'
        echo 'Cloning Robots'
        dir('./robot/') {
          git branch: 'main', url: 'https://github.com/rratchapol/jenkins-assignment.git'
        }
        echo 'Running Robot'
        sh 'cd ./robot && python3 -m robot ./test-api.robot'
      }
    }
    stage('Building Image ️') {
      steps {
        sh 'docker build -t tao/jenkins-assignment:latest .'
      }
    }
    stage('Push ⬆️') {
      steps {
        sh 'docker push tao/jenkins-assignment:latest'
      }
    }
    stage('Clean Workspace') {
      steps {
        echo 'DownTime'
        sh 'docker compose -f ./docker-compose.dev.yaml down'
        sh 'docker system prune -a -f'
      }
    }
    stage('Running Preprod') {
      agent {
        label 'vm3'
      }
      steps {
        sh 'docker compose down && docker system prune -a -f && docker compose up -d --build'
      }
    }
  }
}
