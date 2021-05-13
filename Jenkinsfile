pipeline {
    agent {label slave}
    stages {
        stage('Build') {
            steps{
                script{
                    sh 'npm install'
                }
            }
        }
    }
}