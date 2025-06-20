pipeline {
    agent any

    stages {
        
        stage('Setupping Python ENV and Dependencies') {
            steps {
                sh '''
                    python3 -m venv test_venv
                    bash -c "source test_venv/bin/activate && \
                             pip install --upgrade pip && \
                             pip install -r requirements.txt"
                '''
            }
        }

        stage('Analyze Linting (Pylint)') {
            steps {
                echo "Checking Linting on Python code for ${env.BRANCH_NAME}"
                
            }
        }

        stage('Analyze Linting (Robocop)') {
            steps {
                echo "Checking Linting on robot scripts for ${env.BRANCH_NAME}"
                sh '''#!/bin/bash
                    set -e
                    source test_venv/bin/activate
                    robocop check ui/tests/
                    robocop format ui/tests/
                '''

            }
        }



        stage('Executing UI Regression Tests') {
            steps {
                echo "Running Robot with Pabot tests for ${env.BRANCH_NAME}"
                sh '''
                    bash -c "source test_venv/bin/activate && \
                             pabot --processes 2  --listener allure_robotframework:allure-results ui/tests/"
                '''
            }
        }

        stage('Executing API Regression Tests') {
            steps {
                echo "Running Robot with Pabot tests for ${env.BRANCH_NAME}"
                
            }
        }

        stage('Executing Visual Regression Tests') {
            steps {
                echo "Running Robot with Pabot tests for ${env.BRANCH_NAME}"
                
            }
        }

        stage('Executing DB Regression Tests') {
            steps {
                echo "Running Robot with Pabot tests for ${env.BRANCH_NAME}"
                
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

        stage('Publising Allure with AWS S3') {
            steps {
                echo "Exporting Allure Results into AWS S3 ${env.BRANCH_NAME}"
                
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
