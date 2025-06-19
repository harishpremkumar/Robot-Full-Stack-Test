pipeline {
    agent any

    stages {
        
        stage('Installing Dependencies') {
            steps {
                sh '''
                    python3 -m venv test_venv
                    bash -c "source test_venv/bin/activate && \
                             pip install --upgrade pip && \
                             pip install -r requirements.txt"
                '''
            }
        }

        

        stage('Test') {
            steps {
                echo "Running Robot with Pabot tests for ${env.BRANCH_NAME}"
                sh '''
                    bash -c "source test_venv/bin/activate && \
                             pabot --processes 2  --listener allure_robotframework:allure-results ui/tests/"
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
