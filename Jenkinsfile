/* Created by Jeremie CUADRADO
 Under GNU AFFERO GENERAL PUBLIC LICENSE
*/

pipeline {
    agent any


    environment {
        branchVName = 'master'
        TAG = '0.3'
        DOCKER_GID = '998'
    }

    stages{
        stage('Clone the GitHub repo'){
            steps{
                git url: "https://github.com/redbeard28/jenkins_master.git", branch: "${branchVName}", credentialsId: "jenkins_github_pat"
            }
            post{
                success{
                    echo 'Succefuly clone your repo...'
                }
            }
        }
        stage('Build the Image...'){
            /*steps{
                timeout(time:5, unit:'MINUTES'){
                    input message:'Approuve Image Building'
                }
            }*/

            steps{
                script {
                    withDockerServer([uri: "tcp://${DOCKER_TCPIP}"]) {
                        /* login to the registry and push */
                        withDockerRegistry([credentialsId: 'DOCKERHUB', url: "https://index.docker.io/v1/"]) {
                            /* Prepare build command */
                            def image = docker.build("redbeard28/jenkins_master:${TAG}","--build-arg DOCKER_GID=${DOCKER_GID} -f Dockerfile .")

                            image.push()

                        }
                    }
                }
            }
        }
    }
}