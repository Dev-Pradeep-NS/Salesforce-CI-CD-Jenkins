pipeline {
    agent any
    
    environment {
        SF_CONSUMER_KEY = "${env.SF_CONSUMER_KEY}"
        SF_USERNAME = "${env.SF_USERNAME}"
        SERVER_KEY_PASSWORD = "${env.SERVER_KEY_PASSWORD}"
        TEST_LEVEL = 'RunLocalTests'
        SCRATCH_ORG_ALIAS = 'developmentOrg'
        ROOTDIR = 'force-app/main/default/'
    }

    stages {
        stage('checkout source') {
            steps {
                checkout scm
            }
        }

        stage('Decrypt server key') {
            steps {
                script {
                    sh 'openssl aes-256-cbc -d -in assets/server.key.enc -out assets/server.key -k ${SERVER_KEY_PASSWORD} -pbkdf2'
                    echo 'successfully decrypted'
                }
            }
        }

        stage('Authorize DevHub') {
            steps {
                script {
                    sh 'sf org login jwt --client-id ${SF_CONSUMER_KEY} --jwt-key-file assets/server.key --username ${SF_USERNAME} --alias pradeepDevOrg --set-default-dev-hub'
                    echo 'Authorization successful'
                }
            }  
        }

        stage('Create a new Scratch org') {
            steps {
                script {
                    sh 'sf org create scratch --definition-file config/project-scratch-def.json --set-default --alias ${SCRATCH_ORG_ALIAS} --duration-days 7 --wait 30'
                    echo 'Created Scratch Org'
                }
            }
        }

        stage('Push source to scratch org') {
            steps {
                script {
                    sh 'sf project deploy start  --source-dir ${ROOTDIR} --target-org ${SCRATCH_ORG_ALIAS}'
                    echo 'Source code has been pushed to scratch org'
                }
            }
        }

        stage('Test the deployment') {
            steps {
                script {
                    sh 'sf apex run test --target-org ${SCRATCH_ORG_ALIAS}'
                    echo 'All Test cases passed'
                }
            }
        }

        stage('Delete Scratch Org') {
            steps {
                script {
                    sh 'sf org delete scratch --target-org ${SCRATCH_ORG_ALIAS} --no-prompt'
                    echo 'Deleted Scratch org'
                }
            }
        }
    }
}
