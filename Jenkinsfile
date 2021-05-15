pipeline {
    /**
     *  In this example, the agent's Dockerfile is within the repository.
     *  Therefore, you must use this example only in "Multibranch Pipeline" or a "Pipeline from SCM".
     *  More information here: https://jenkins.io/doc/book/pipeline/syntax/#agent under "dockerfile".
     */
    agent {
        dockerfile { label 'master' }
    }

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

                rtNpmResolver(
                        id: 'npm_resolver',
                        serverId: 'Artifactory_Server',
                        repo: 'forcepoint-npm-remote'
                )

                rtNpmDeployer(
                        id: 'npm_deployer',
                        serverId: 'Artifactory_Server',
                        repo: 'forcepoint-npm-local'
                )
            }
        }

        stage('Exec npm install') {
            steps {
                rtNpmInstall(
                        resolverId: 'npm_resolver'
                )
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