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
                git url: "https://github.com/redbeard28/jenkins_slave.git", branch: "${branchVName}", credentialsId: "jenkins_github_pat"
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
                    /* def customImage = docker.build("redbeard28/jenkins_slave:${TAG}")
                    customImage.push() */
                    withDockerRegistry([credentialsId: 'DOCKERHUB', url: "https://index.docker.io/v1/"]) {
                        def image = docker.build("redbeard28/jenkins_slave:${TAG}","--build-arg DOCKER_GID='$DOCKER_GID'","-f Dockerfile")
                    image.push()
                    }
                }

            }
        }
    }
}
