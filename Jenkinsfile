pipeline{
    agent any
    tools{
        maven 'maven_3.9.4'
        terraform 'terraform_30186'
    }
    stages{
        stage('build maven'){
            steps{
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/23piyush/kubernetes-practice']])
                dir('./shopfront') {
                sh 'mvn clean install'
                }
                dir('./productcatalogue'){
                    sh 'mvn clean install'
                }
            }
        }
        stage('Build docker image'){
            steps{
                script{
                    dir('./shopfront') {
                        sh 'docker build -t 8209820403/shopfront:latest .'
                    }
                    dir('./productcatalogue') {
                        sh 'docker build -t 8209820403/productcatalogue:latest .'
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
                    sh 'docker push 8209820403/shopfront:latest'
                    sh 'docker push 8209820403/productcatalogue:latest'
                }
            }
        }
        // stage('Deploy to kubernetes'){
        //     steps{
        //         script{
        //             dir('./kubernetes'){
        //                 kubernetesDeploy configs: 'productcatalogue-service.yaml', kubeConfig: [path: ''], kubeconfigId: 'k8sconfigpwd', secretName: '', ssh: [sshCredentialsId: '*', sshServer: ''], textCredentials: [certificateAuthorityData: '', clientCertificateData: '', clientKeyData: '', serverUrl: 'https://']
        //                 kubernetesDeploy configs: 'shopfront-service.yaml', kubeConfig: [path: ''], kubeconfigId: 'k8sconfigpwd', secretName: '', ssh: [sshCredentialsId: '*', sshServer: ''], textCredentials: [certificateAuthorityData: '', clientCertificateData: '', clientKeyData: '', serverUrl: 'https://']
        //             }
        //         }
        //     }
        // }
        stage('Terraform init'){
            steps{
                sh 'terraform init'
            }
        }
        stage('Terraform apply'){
            steps{
                sh 'terraform apply --auto-approve'
            }
        }
    }
}