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
        docker.build("ci-kubernetes-master-1.node.cyber.local:8082/docker-local/forcepoint:${env.BUILD_ID}")
    }

    stage ('Push image to Artifactory') {
        rtDocker.push 'ci-kubernetes-master-1.node.cyber.local:8082/docker-local/forcepoint:' + "${env.BUILD_ID}", 'docker-local', buildInfo
    }

    stage ('Publish build info') {
        server.publishBuildInfo buildInfo
    }

    stage('Deploying into k8s'){
        sh 'kubectl apply -f forcepoint.yaml'
    }
}