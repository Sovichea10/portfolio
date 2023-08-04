pipeline {
    agent any

    environment {
        BOT_TOKEN = credentials('Telegram_BotToken')
        CHAT_ID = credentials('Telegram_ChatID')

        // docker login
        USERNAME = credentials('docker_user')
        PASSWORD = credentials('docker_password')
    }

    stages {
        stage('Start') {
            steps {
                echo "Welcome Jenkins!"
            }
        }
        stage('Deploy') {
            steps {
                sh 'ssh -o StrictHostKeyChecking=no root@128.199.131.91 "cd /apps/website;\
                git fetch;\
                git checkout test;\
                git pull;\
                docker-compose up -d --build;\
                "'
            }
        }
        stage('login and push to registry') {
            steps {
                sh 'ssh -o StrictHostKeyChecking=no root@128.199.131.91 "cd /apps/;\
                docker login --username $env.USERNAME --password $env.PASSWORD;\
                "'
            }
        }
        stage('Ending') {
            steps {
                echo "$env.USERNAME"
                echo "Ending"
            }
        }
    }
    post{
        success{
            sh '''
            sh 1-success-deploy.sh;\
            '''
        }
        failure{
            sh '''
            sh 2-fail-deploy.sh;\
            '''
        }
    }
}
