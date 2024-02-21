pipeline {
    agent any
    
    environment {
        REPO_URL = 'https://github.com/OT-MICROSERVICES/attendance-api.git'
        DEP_CHECK_VERSION = '9.0.9'
    }
    
    stages {
        stage('Code Checkout') {
            steps {
                git branch: 'main', credentialsId: 'Attendance-creds', url: "${REPO_URL}"
            }
        }

        stage('Setup Environment') {
            steps {
                script {
                    sh 'python3 -m venv myenv'
                    sh '. myenv/bin/activate'
                    sh "echo 'pylint==3.0.3' >  requirements.txt"
                    sh 'pip install -r requirements.txt'
                    sh 'pip install bandit'
                    sh 'pip install pytest pytest-html Flask Flask-Caching'
                    sh "wget -q https://github.com/jeremylong/DependencyCheck/releases/download/v${DEP_CHECK_VERSION}/dependency-check-${DEP_CHECK_VERSION}-release.zip"
                    sh "unzip -o -q dependency-check-${DEP_CHECK_VERSION}-release.zip"
                }
            }
        }

        stage('Static Code Analysis - pylint') {
            steps {
                script {
                    sh 'pylint router/ client/ models/ utils/ app.py | tee pylint.log'
                }
            }
        }

        stage('Bugs Analysis - Bandit') {
            steps {
                script {
                    try {
                        sh 'bandit --version'
                        sh '/usr/bin/bandit -r . -f json -o bandit_report.json'
                    } catch (Exception e) {
                        echo "Bugs analysis failed: ${e.message}"
                    }
                }
            }
        }

        stage('Unit Test - Pytest') {
            steps {
                script {
                    sh '/usr/local/bin/pytest router/tests/test_cache.py'
                }
            }
        }

        stage('OWASP Dependency-Check') {
            steps {
                script {
                    sh 'dependency-check/bin/dependency-check.sh --scan . --out dep-check.html'
                }
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '**/pylint.log', allowEmptyArchive: true
            publishHTML(target: [
                allowMissing: false,
                alwaysLinkToLastBuild: true,
                keepAll: true,
                reportDir: '.',
                reportFiles: 'bandit_report.json',
                reportName: 'Bandit Security Report'
            ])
        }
    }
}
