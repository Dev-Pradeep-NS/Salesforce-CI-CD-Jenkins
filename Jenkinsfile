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
                    def rc = sh(script: 'openssl aes-256-cbc -d -in assets/server.key.enc -out assets/server.key -k ${SERVER_KEY_PASSWORD} -pbkdf2', returnStatus: true)
                    if (rc != 0) {
                        error 'Could not decrypt the server key'
                    }
                }
            }
        }

        stage('Authorize DevHub') {
            steps {
                withCredentials([file(credentialsId: env.SERVER_KEY_CREDENTALS_ID, variable: 'server_key_file')]) {
                    script {
                        def rc = sh(script: 'sf org login jwt --client-id ${SF_CONSUMER_KEY} --jwt-key-file assets/server.key --username ${SF_USERNAME} --alias pradeepDevOrg --set-default-dev-hub', returnStatus: true)
                        if (rc != 0) {
                            error 'Salesforce dev hub org authorization failed.'
                        }
                    }
                }
            }
        }

        stage('Create a new Scratch org') {
            steps {
                script {
                    def rc = sh(script: 'sf org create scratch --definition-file config/project-scratch-def.json --set-default --alias ${SCRATCH_ORG_ALIAS} --duration-days 7 --wait 30', returnStatus: true)
                    if (rc != 0) {
                        error 'Could not create scratch org'
                    }
                }
            }
        }

        stage('Push source to scratch org') {
            steps {
                script {
                    def rc = sh(script: 'sf project deploy start  --source-dir ${ROOTDIR} --target-org ${SCRATCH_ORG_ALIAS}', returnStatus: true)
                    if (rc != 0) {
                        error 'Could not Deploy to scratch org'
                    }
                }
            }
        }

        stage('Test the deployment') {
            steps {
                script {
                    def rc = sh(script: 'sf apex run test --target-org ${SCRATCH_ORG_ALIAS}', returnStatus: true)
                    if (rc != 0) {
                        error 'Test failed'
                    }
                }
            }
        }

        stage('Delete Scratch Org') {
            steps {
                script {
                    def rc = sh(script: 'sf org delete scratch --target-org ${SCRATCH_ORG_ALIAS} --no-prompt', returnStatus: true)
                    if (rc != 0) {
                        error 'Could not delete the scratch org'
                    }
                }
            }
        }
    }
}
