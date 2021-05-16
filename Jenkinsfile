pipeline {
    
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }
    agent any

    stages {
        stage('checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/basu-github/ec2_jenkins.git'
            }
        }
        stage('Set Terraform path') {
           steps {
              script {
              def tfHome = tool name: 'terraform', type: 'terraform'
              env.PATH = "${tfHome}:${env.PATH}"
              }
            sh 'terraform version'
 }
 }
        stage('terraform apply') {
            steps {
                sh "terraform init"
                sh "terraform plan"
                sh "terraform apply --auto-approve"
                sleep time: 2, unit: 'MINUTES'
            }
        }
        stage('terraform destroy') {
            steps {
                sh "terraform destroy --auto-approve"
            }
        }
    }
}

