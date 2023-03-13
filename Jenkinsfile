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
				    sh 'set ARM_CLIENT_ID="CLIENT_ID"'
				    sh 'set ARM_CLIENT_SECRET="CLIENT_SECRET"'
		                    sh 'set ARM_SUBSCRIPTION_ID="SUBS_ID"'
		                    sh 'set ARM_TENANT_ID="TENANT_ID"'
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
 
