node {
    def server
    def rtDocker
    def buildInfo

    stage ('Clone') {
        git url: 'https://github.com/matanz121/forcepoint.git/'
    }

    stage ('Artifactory configuration') {
        server = Artifactory.server SERVER_ID
        rtDocker = Artifactory.docker server: server
        buildInfo = Artifactory.newBuildInfo()
    }

    stage ('Add properties') {
        // Attach custom properties to the published artifacts:
        rtDocker.addProperty("project-name", "forcepoint").addProperty("status", "stable")
    }

    stage('Build docker image') {
        dockerImage = docker.build("forcepoint:${env.BUILD_ID}")
    }

    stage ('Push image to Artifactory') {
        rtDocker.push ARTIFACTORY_DOCKER_REGISTRY + '/"forcepoint:${env.BUILD_ID}"', 'docker-local', buildInfo
    }

    stage ('Publish build info') {
        server.publishBuildInfo buildInfo
    }
}