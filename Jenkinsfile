pipeline {
    agent any

    stages {
        stage('Test') {
            steps {
                echo "Running Robot tests for ${env.BRANCH_NAME}"
                sh '''
                    robot --listener allure_robotframework:allure-results /home/jenkins/project/tests/new.robot
                '''
            }
        }

        stage('Generate Allure Report') {
            steps {
                echo "Generating Allure Report..."
                sh '''
                    allure generate --clean \
                        -o /home/jenkins/.jenkins/workspace/test/allure-report \
                        /home/jenkins/project/tests/allure-results
                '''
            }
        }
     
    }

    post {
        always {
            echo "Publishing Allure Report..."
            allure([
                includeProperties: false,
                jdk: '',
                reportBuildPolicy: 'ALWAYS',
                results: [[path: 'test/allure-results']]
            ])
        }
    }
}
