pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo "Building branch ${env.BRANCH_NAME}"
            }
        }
        stage('Test') {
            steps {
                echo "Running tests for ${env.BRANCH_NAME}"
            }
        }
        stage('Deploy') {
            when {
                branch 'main'
            }
            steps {
                echo "Deploying ${env.BRANCH_NAME}"
            }
        }
    }
}
