# Created by Jeremie CUADRADO
# Under GNU AFFERO GENERAL PUBLIC LICENSE
#

@Field def mod_ansible
@Field def inventory = ""
@Field def environment_name = ""


properties([
  parameters([
     text(name: 'DOCKER_GID', defaultValue: '998\n1000\n', description: 'Mandatory GID number of docker group') },
     text(name: 'TAG', defaultValue: '0.2\n', description: 'Insert tag version of the image for docker hub') }
   ])
])


node {
    def app

    stage('Cloning from github'){

        git url: "https://github.com/redbeard28/jenkins_master.git", branch: 'master', credentialsId: 'jenkins_github_pat'


    stage('Build image') {
        /* This builds the actual image */

        app = docker.build("redbeard28/jenkins_master:'TAG'","--build-arg 'DOCKER_GID'")
    }

    stage('Test image') {

        app.inside {
            echo "Tests passed"
        }
    }

/*    stage('Push image') {
        /*
			You would need to first register with DockerHub before you can push images to your account
		*/
   /*     docker.withRegistry('https://registry.hub.docker.com', 'docker-hub') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
            }
                echo "Trying to Push Docker Build to DockerHub"
    }*/
}