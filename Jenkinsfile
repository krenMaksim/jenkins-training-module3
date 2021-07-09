pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                git url: 'https://github.com/krenMaksim/jenkins-training-module3.git', branch: 'master'
                
                sh 'mvn clean install'
                
                script {
                    dockerImage = docker.build("krenmaksim/module3-jenkins:${env.BUILD_ID}")
                }
            }
        }
        
        stage('image push') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: "dockerhub", usernameVariable: 'login', passwordVariable: 'password')]) {
                        sh """
                        docker login -u ${login} -p ${password}
                        docker push krenmaksim/module3-jenkins:${env.BUILD_ID}
                        """
                    }
                }
            }
        }
        
        stage('publish') {
            steps {
                script {
                    env.PRODUCT_SERVICE_TAG = "${env.BUILD_ID}"
                    kubernetesDeploy(configs: 'deployment.yaml', kubeconfigId: 'kubeconfig')
                }
            }
        }
    }
}