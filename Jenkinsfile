pipeline {
    agent {label 'k8s_server'}

    stages {
        stage ('Clone') {
            steps {
                git branch: 'master', url: "https://github.com/matanz121/forcepoint.git/"
            }
        }

        stage ('Artifactory configuration') {
            steps {
                rtServer (
                    id: 'Artifactory_Server',
                    url: 'http://ci-kubernetes-master-1.node.cyber.local:8082/artifactory',
                    credentialsId: CREDENTIALS
                )
            }
        }
        
        stage ('Change version tag number') {
            steps {
                sh "sed -ir 's/__TAG__/${env.BUILD_ID}/g' forcepoint.yaml"
            }
        }

        stage ('Build docker image') {
            steps {
                script {
                    docker.build("ci-kubernetes-master-1.node.cyber.local:8082/docker-local/forcepoint:${env.BUILD_ID}")
                }
            }
        }

        stage ('Push image to Artifactory') {
            steps {
                rtDockerPush(
                    serverId: 'Artifactory_Server',
                    image: 'ci-kubernetes-master-1.node.cyber.local:8082/docker-local/forcepoint:' + "${env.BUILD_ID}",
                    targetRepo: 'docker-local',
                    properties: 'project-name=forcepoint;status=stable'
                )
            }
        }

        stage ('Publish build info') {
            steps {
                rtPublishBuildInfo (
                    serverId: 'Artifactory_Server',
                )
            }
        }
        stage ('K8s deployment') {
            steps {
                kubernetesDeploy(configs: "forcepoint.yaml", kubeconfigId: "mykubeconfig")
            }
        }
    }
}