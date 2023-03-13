pipeline {
    agent any
    stages {
        
	    stage('Checkout') {
            steps {
            checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Aditya24Joshi/TerraformTest.git']]])            

          }
        }
	    
	    stage('Login to Azure and initialize terraform') {
		steps{ withCredentials([azureServicePrincipal(credentialsId: 'AzureServicePrincipal',
                                    subscriptionIdVariable: 'SUBS_ID',
                                    clientIdVariable: 'CLIENT_ID',
                                    clientSecretVariable: 'CLIENT_SECRET',
                                    tenantIdVariable: 'TENANT_ID')]) {
        			    sh 'az login --service-principal -u $CLIENT_ID -p $CLIENT_SECRET -t $TENANT_ID'
				    sh 'set ARM_CLIENT_ID=4c7445ec-7cb0-4ada-a372-b67de96b398d'
				    sh 'set ARM_CLIENT_SECRET=P3_8Q~oP3sgCHw2HSVn-f87z5zzxrmfgG4Fhfbhp'
		                    sh 'set ARM_SUBSCRIPTION_ID=3c891e52-07ee-4dac-b159-2e9e107ae8b0'
		                    sh 'set ARM_TENANT_ID=724c6201-042e-4a56-852e-636887bad72f'
				    sh 'echo %"TENANT_ID"%'
				    sh ('terraform init') 
          }
   }	      
}		      
		      
        stage ("terraform Apply") {
            steps {
                
                sh ('terraform apply') 
           }
        }
        
        }
      }
 
