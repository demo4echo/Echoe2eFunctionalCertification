// We can omit this one as we marked the shared library to load implicitly
@Library('EchoSharedLibrary') _

// Load shared resources
def jenkinsSlavePodManifestResourceAsString = libraryResource 'jenkinsSlavePodManifest.yaml'

pipeline {
	agent {
		kubernetes {
			cloud pipelineCommon.resolveCloudNameByJobName()
			label pipelineCommon.K8S_AGENT_LABEL
			defaultContainer pipelineCommon.K8S_AGENT_DEFAULT_CONTAINER
			yaml jenkinsSlavePodManifestResourceAsString
		}
	}
	options { 
		timestamps() 

		buildDiscarder(logRotator(numToKeepStr: pipelineCommon.OPTIONS_BUILD_DISCARDER_LOG_ROTATOR_NUM_TO_KEEP_STR))
	}
	environment {
		// We use this dummy environment variable to load all the properties from the designated file into environment variable (per branch)
		// This is indeed a pseudo comment 4 All
//		X_EFRAT_ECHO_DUMMY_ENV_VAR = assimilateEnvironmentVariables()
	}
	stages {
		stage('\u2776 certify (functional) \u2728') {//\u1F4A1
			steps {
				sh './certify'
			}
		}
	}
	post {
		always {
			echo 'One way or another, I have finished'
		}
		success {
			echo 'I succeeded!'
			junit 'target/**/*.xml'
			cucumber 'target/**/*.json'
		}
		unstable {
			echo 'I am unstable :/'
		}
		failure {
			echo 'I failed :('
		}
		changed {
			echo 'Things were different before...'
		}
	}
}
