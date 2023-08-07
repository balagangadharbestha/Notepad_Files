node {
     stage('clone'){
	     git 'https://github.com/balagangadharbestha/maven-web-application.git'
         }
    stage('Maven clean') {
      sh 'mvn clean' 
    }
    stage('Maven validate') {
      sh 'mvn validate'
    }
    stage('Maven compile') {
      sh 'mvn compile' 
    }
    stage('Maven test') {
      sh 'mvn test'
    }
    stage('Maven package') {
      sh 'mvn package'
	}
	stage('Maven deploy') {
      sh 'mvn deploy'
	}
}
