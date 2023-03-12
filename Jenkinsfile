pipeline {
    agent any

environment{
path= "tmp0oebd5x0.pem"
}

    stages {
        stage('Login to Azure') {
            steps {
                
		  sh '
az login --service-principal --username f6e29b7a-369d-4a6f-ace0-6ca52c4e7f47 --tenant 724c6201-042e-4a56-852e-636887bad72f --password $path'
            }
        }
    }
}
