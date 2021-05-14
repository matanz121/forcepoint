pipeline {
    /**
     *  In this example, the agent's Dockerfile is within the repository.
     *  Therefore, you must use this example only in "Multibranch Pipeline" or a "Pipeline from SCM".
     *  More information here: https://jenkins.io/doc/book/pipeline/syntax/#agent under "dockerfile".
     */
    agent { label 'slave'}
    environment {
        npm_config_cache = 'npm-cache'
    }

    stages {
        stage('Artifactory configuration') {
            steps {
                rtServer(
                        id: 'Artifactory_Server',
                        url: "http://10.164.237.25:8082/artifactory",
                        credentialsId: CREDENTIALS
                )

                rtNpmResolver(
                        id: "NPM_RESOLVER",
                        serverId: 'Artifactory_Server',
                        repo: "forcepoint-npm-remote"
                )

                rtNpmDeployer(
                        id: "NPM_DEPLOYER",
                        serverId: 'Artifactory_Server',
                        repo: "forcepoint-npm-local"
                )
            }
        }

        stage('Exec npm install') {
            steps {
                rtNpmInstall(
                        path: "npm-example",
                        resolverId: "NPM_RESOLVER"
                )
            }
        }

        stage('Exec npm publish') {
            steps {
                rtNpmPublish(
                        path: "npm-example",
                        deployerId: "NPM_DEPLOYER"
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