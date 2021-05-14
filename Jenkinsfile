pipeline {
    agent {
        dockerfile {
            dir 'npm'
        }
    }

    environment {
        npm_config_cache = 'npm-cache'
    }

    stages {
        stage('Artifactory configuration') {
            steps {
                rtServer(
                        id: "ARTIFACTORY_SERVER",
                        url: SERVER_URL,
                        credentialsId: CREDENTIALS
                )

                rtNpmResolver(
                        id: "NPM_RESOLVER",
                        serverId: "ARTIFACTORY_SERVER",
                        repo: "npm-remote"
                )

                rtNpmDeployer(
                        id: "NPM_DEPLOYER",
                        serverId: "ARTIFACTORY_SERVER",
                        repo: "npm-local"
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
                        serverId: "ARTIFACTORY_SERVER"
                )
            }
        }
    }
}