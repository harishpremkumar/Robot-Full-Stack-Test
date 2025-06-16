pipeline {
    agent any

    stages {
        stage('Test') {
            steps {
                echo "Running Robot tests for ${env.BRANCH_NAME}"
                sh '''
                    ls
                '''
            }
        }

        // stage('Generate Allure Report') {
        //     steps {
        //         echo "Generating Allure Report..."
        //         sh '''
        //             allure generate --clean \
        //                 -o /home/jenkins/.jenkins/workspace/test/allure-report \
        //                 /home/jenkins/project/tests/allure-results
        //         '''
        //     }
        // }
     
    }


}
