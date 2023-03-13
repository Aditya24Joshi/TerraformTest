pipeline {
    agent any
    stages {
        stage('Login to Azure') {
		/*steps{ withCredentials([azureServicePrincipal(credentialsId: 'AzureServicePrincipal',
                                    subscriptionIdVariable: 'SUBS_ID',
                                    clientIdVariable: 'CLIENT_ID',
                                    clientSecretVariable: 'CLIENT_SECRET',
                                    tenantIdVariable: 'TENANT_ID')]) {
     sh 'az login --service-principal -u $CLIENT_ID -p $CLIENT_SECRET -t $TENANT_ID'*/
			
			echo "skipped"
          }
   }	      
}		      
		      stage('Checkout') {
            steps {
            checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Aditya24Joshi/TerraformTest.git']]])            

          }
        }
        
        stage ("terraform init") {
            steps {
		  sh 'export ARM_CLIENT_ID="CLIENT_ID"'
		  sh 'export ARM_CLIENT_SECRET="CLIENT_SECRET"'
		  sh 'export ARM_TENANT_ID="TENANT_ID"'
		  sh 'export ARM_SUBSCRIPTION_ID="SUBS_ID"'
                sh ('terraform init') 
            }
        }
        
        stage ("terraform Apply") {
            steps {
                
                sh ('terraform apply') 
           }
        }
        
        }
      }
 
