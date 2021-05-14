pipeline {
    agent {label 'slave'}
    stages {
        stage('Build') {
            steps{
                script{
                    sh 'npm init -y'
                    sh 'npm install express --save'
                }
            }
        }
    }
}