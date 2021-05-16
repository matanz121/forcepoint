node {
    def server = Artifactory.server SERVER_ID
    def rtNpm = Artifactory.newNpmBuild()
    def dockerImage
    def buildInfo

    stage('Clone') {
        git url: 'https://github.com/matanz121/forcepoint.git/'
    }

    stage('Artifactory configuration') {
        rtNpm.deployer repo: 'forcepoint-npm-local', server: server
        rtNpm.resolver repo: 'forcepoint-npm-remote', server: server
        buildInfo = Artifactory.newBuildInfo()
    }

    stage('Build docker image') {
        dockerImage = docker.build("forcepoint:${env.BUILD_ID}")
    }

    withEnv(['npm_config_cache=npm-cache']) {
        dockerImage.inside() {
            stage('Install npm') {
                rtNpm.install buildInfo: buildInfo
            }
            stage('Publish npm') {
                rtNpm.publish buildInfo: buildInfo
            }
        }
    }

    stage('Publish build info') {
        server.publishBuildInfo buildInfo
    }
}