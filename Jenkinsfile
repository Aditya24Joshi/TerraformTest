pipeline {
    agent any
    stages {
        
	    stage('Checkout') {
            steps {
            checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Aditya24Joshi/TerraformTest.git']]])            

          }
        }
	    
	    stage('Login to Azure and initialize terraform') {

				    bat 'set ARM_CLIENT_ID=4c7445ec-7cb0-4ada-a372-b67de96b398d'
				    bat 'set ARM_CLIENT_SECRET=P3_8Q~oP3sgCHw2HSVn-f87z5zzxrmfgG4Fhfbhp'
		                    bat 'set ARM_SUBSCRIPTION_ID=3c891e52-07ee-4dac-b159-2e9e107ae8b0'
		                    bat 'set ARM_TENANT_ID=724c6201-042e-4a56-852e-636887bad72f'
				    bat 'echo %TENANT_ID%'
				    bat 'terraform init'
   	      
}		      
		      
        stage ("terraform Apply") {
            steps {
                
                sh ('terraform apply') 
           }
        }
     }
}
        
      
 
