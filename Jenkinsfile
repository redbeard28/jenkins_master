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
                    /* Prepare build command */
                    def image = docker.build("redbeard28/jenkins_master:${TAG}")
                    def imageArgs = image.run("--build-arg DOCKER_GID=${DOCKER_GID}")

                    /* login to the registry and push */
                    withDockerRegistry([credentialsId: 'DOCKERHUB', url: "https://index.docker.io/v1/"]) {

                        imageArgs.push()

                    }
                }

            }
        }
    }
}
/*
   dbImage = docker.build('oracle', 'docker/oracle')
   db = dbImage.run("-p 49160:22 -p 49161:1521")
   wlpImage = docker.build('liberty', 'docker/liberty')
   wlp = wlpImage.run("-p 9080:9080 --link=${db.id}:oracle")
  }
  stage('Push image to registry') {
      docker.withRegistry('https://localhost:5000') {
          dbImage.push()
          wlpImage.push()
      }
     }
*/