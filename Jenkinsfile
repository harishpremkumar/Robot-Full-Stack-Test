pipeline {
    agent any

    stages {

        stage('Setup') {
            steps {
                sh '''
                    echo "Installing Chrome browser..."

                    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor > /usr/share/keyrings/google-chrome.gpg
                    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list

                    apt-get update
                    apt-get install -y google-chrome-stable libnss3 libgconf-2-4 libxss1 libappindicator1 libindicator7 fonts-liberation libasound2 xdg-utils

                    google-chrome --version
                '''
            }
        }


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
                echo "Running Robot tests for ${env.BRANCH_NAME}"
                sh '''
                    bash -c "source test_venv/bin/activate && \
                             robot --listener allure_robotframework:allure-results ui/tests/test_login_ui.robot"
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
