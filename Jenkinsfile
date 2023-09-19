pipeline{
    agent any
    tools{
        maven 'maven_3.9.4'
    }
    stages{
        stage('build maven'){
            steps{
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/23piyush/kubernetes-practice']])
                dir('./shopfront') {
                sh 'mvn clean install'
                }
            }
        }
        stage('Build docker image'){
            steps{
                script{
                    dir('./shopfront') {
                sh 'docker build -t 8209820403/shopfront .'
                }
                }
            }
        }
        stage('push docker image to docker hub'){
            steps{
                script{   
                    withCredentials([string(credentialsId: 'dockerhubpwd', variable: 'dockerhubpwd')]) {
                        sh 'docker login -u 8209820403 -p ${dockerhubpwd}'
                            }
                    sh 'docker push 8209820403/shopfront'
                }
            }
        }
        stage('Deploy to kubernetes'){
            steps{
                script{
                    dir('./kubernetes'){
                        kubernetesDeploy configs: 'shopfront-service.yaml', kubeConfig: [path: ''], kubeconfigId: 'k8sconfigpwd', secretName: '', ssh: [sshCredentialsId: '*', sshServer: ''], textCredentials: [certificateAuthorityData: '', clientCertificateData: '', clientKeyData: '', serverUrl: 'https://']
                    }
                }
            }
        }
    }
}