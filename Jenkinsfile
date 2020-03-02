// We can omit this one as we marked the shared library to load implicitly
@Library('EchoSharedLibrary') _

// Load shared resources
def jenkinsSlavePodManifestResourceAsString = libraryResource 'jenkinsSlavePodManifest.yaml'

pipeline {
	agent {
		kubernetes {
//			cloud pipelineCommon.resolveCloudNameByJobName()
			cloud pipelineCommon.resolveCloudNameByBranchName()
			label pipelineCommon.constructJenkinsSlavePodAgentLabel()
			defaultContainer pipelineCommon.K8S_AGENT_DEFAULT_CONTAINER
			yaml jenkinsSlavePodManifestResourceAsString
		}
	}
	options { 
		timestamps() 

		buildDiscarder(logRotator(numToKeepStr: pipelineCommon.OPTIONS_BUILD_DISCARDER_LOG_ROTATOR_NUM_TO_KEEP_STR))
	}
	triggers {
		upstream(upstreamProjects: "echobe/${env.BRANCH_NAME},echofe/${env.BRANCH_NAME}", threshold: hudson.model.Result.SUCCESS)
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
