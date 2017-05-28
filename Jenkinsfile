/**
* NOTE: THIS JENKINSFILE IS GENERATED VIA "./hack/run update"
*
* DO NOT EDIT IT DIRECTLY.
*/
node {
        def versions = "3.2".split(',');
        for (int i = 0; i < versions.length; i++) {
                try {
                        stage("Build (Redis ${versions[i]})") {
                                openshift.withCluster() {
        openshift.apply([
                                "apiVersion" : "v1",
                                "items" : [
                                        [
                                                "apiVersion" : "v1",
                                                "kind" : "ImageStream",
                                                "metadata" : [
                                                        "name" : "redis",
                                                        "labels" : [
                                                                "builder" : "redis-component"
                                                        ]
                                                ],
                                                "spec" : [
                                                        "tags" : [
                                                                [
                                                                        "name" : "${versions[i]}-alpine",
                                                                        "from" : [
                                                                                "kind" : "DockerImage",
                                                                                "name" : "redis:${versions[i]}-alpine",
                                                                        ],
                                                                        "referencePolicy" : [
                                                                                "type" : "Source"
                                                                        ]
                                                                ]
                                                        ]
                                                ]
                                        ],
                                        [
                                                "apiVersion" : "v1",
                                                "kind" : "ImageStream",
                                                "metadata" : [
                                                        "name" : "redis-component",
                                                        "labels" : [
                                                                "builder" : "redis-component"
                                                        ]
                                                ]
                                        ]
                                ],
                                "kind" : "List"
                        ])
        openshift.apply([
                                "apiVersion" : "v1",
                                "kind" : "BuildConfig",
                                "metadata" : [
                                        "name" : "redis-component-${versions[i]}",
                                        "labels" : [
                                                "builder" : "redis-component"
                                        ]
                                ],
                                "spec" : [
                                        "output" : [
                                                "to" : [
                                                        "kind" : "ImageStreamTag",
                                                        "name" : "redis-component:${versions[i]}"
                                                ]
                                        ],
                                        "runPolicy" : "Serial",
                                        "source" : [
                                                "git" : [
                                                        "uri" : "https://github.com/ausnimbus/redis-component"
                                                ],
                                                "type" : "Git"
                                        ],
                                        "strategy" : [
                                                "dockerStrategy" : [
                                                        "dockerfilePath" : "versions/${versions[i]}/Dockerfile",
                                                        "from" : [
                                                                "kind" : "ImageStreamTag",
                                                                "name" : "redis:${versions[i]}-alpine"
                                                        ]
                                                ],
                                                "type" : "Docker"
                                        ]
                                ]
                        ])
        echo "Created redis-component:${versions[i]} objects"
        /**
        * TODO: Replace the sleep with import-image
        * openshift.importImage("redis:${versions[i]}-alpine")
        */
        sleep 60

        echo "==============================="
        echo "Starting build redis-component-${versions[i]}"
        echo "==============================="
        def builds = openshift.startBuild("redis-component-${versions[i]}");

        timeout(10) {
                builds.untilEach(1) {
                        return it.object().status.phase == "Complete"
                }
        }
        echo "Finished build ${builds.names()}"
}

                        }
                        stage("Test (Redis ${versions[i]})") {
                                openshift.withCluster() {
        echo "==============================="
        echo "Starting test application"
        echo "==============================="

        def testApp = openshift.newApp("redis-component:${versions[i]}", "-l app=redis-ex");
        echo "new-app created ${testApp.count()} objects named: ${testApp.names()}"
        testApp.describe()

        def testAppDC = testApp.narrow("dc");
        echo "Waiting for ${testAppDC.names()} to start"
        timeout(10) {
                testAppDC.untilEach(1) {
                        return it.object().status.availableReplicas >= 1
                }
        }
        echo "${testAppDC.names()} is ready"

        def testAppService = testApp.narrow("svc");
        def testAppHost = testAppService.object().spec.clusterIP;
        def testAppPort = testAppService.object().spec.ports[0].port;

        sleep 60
        echo "Testing endpoint ${testAppHost}:${testAppPort}"
        sh "nc -z $testAppHost $testAppPort"
}

                        }
                } finally {
                        openshift.withCluster() {
                                echo "Deleting test resources redis-ex"
                                openshift.selector("dc", [app: "redis-ex"]).delete()
                                openshift.selector("bc", [app: "redis-ex"]).delete()
                                openshift.selector("svc", [app: "redis-ex"]).delete()
                                openshift.selector("is", [app: "redis-ex"]).delete()
                                openshift.selector("pods", [app: "redis-ex"]).delete()
                                openshift.selector("routes", [app: "redis-ex"]).delete()
                        }
                }

        }
}
