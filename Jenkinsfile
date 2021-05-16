pipeline {
    agent { label 'master' }

    environment {
        npm_config_cache = 'npm-cache'
    }

    stages {
        stage('Artifactory configuration') {
            steps {
                rtServer(
                        id: 'Artifactory_Server',
                        url: 'http://10.164.237.25:8082/artifactory',
                        credentialsId: CREDENTIALS
                )

                rtNpmDeployer(
                        id: 'npm_deployer',
                        serverId: 'Artifactory_Server',
                        repo: 'forcepoint-npm-local'
                )
            }
        }

        stage('Install dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Initialize the project') {
            steps {
                sh 'npm init'
            }
        }

        stage ('Build & Deploy') {
            steps {
                docker.build(forcepoint)
            }
        }

        stage('Exec npm publish') {
            steps {
                rtNpmPublish(
                        deployerId: 'npm_deployer'
                )
            }
        }


        stage('Publish build info') {
            steps {
                rtPublishBuildInfo(
                        serverId: 'Artifactory_Server'
                )
            }
        }
    }
}