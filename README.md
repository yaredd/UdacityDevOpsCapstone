# Capstone Project for DevOps

## Overview

In this project I will be deploying a Nginx app to a private Kubernetes cluster. I will be using Jenkins for CI/CD, Ansible for deploying the Kubernetes cluster using the [K3s](https://rancher.com/products) implementation.

## Infrastructure Setup

### Kubernetes with K3s

The K3s setup is carried out using Ansible manifest `infra_setup/install-k3s-cluster.yml`. The K3s documentation details how to install a Highly Available Kubernetes infrastructure with an External DB using a containerized [MariaDB](https://hub.docker.com/r/yobasystems/alpine-mariadb/). The resulting Kubernetes cluster will have 2 Masters and 3 Workers/Agents.
`kubectl` is installed and configured to run the Kubernetes Dashboard installation like so:

```
kubectl apply -f infra_setup/kubernetes-dashboard.yml
```

### Jenkins CI/CD

I have used the dockerized Jenkins setup and configured it to use the local `dockerd daemon via the host's `/var/run/docker.sock`. In addition to the recommended Jenkins plugins, I have installed `kubectl`and configured it with required token for managing the cluster withiyn the Jenkins container. The`kubectl`binary was install in the`jenkins`user's home folder`/var/jenkins_home/kubectl`.
I then setup Jenkins credentials for pushing container images to my [dockerhub](https://hub.docker.com) account.
Jenkinsfile defines the pipeline.

#### Screenshots

- **failing-link-stage.png** - shows the failing linting stage
- **passing-lint-stage.png** - shows the passing linting stage
- **success-deployment-1.png** - build number 17 showing the pods running
- **success-deployment-2.png** - build number 17 showing the deployment test involving a 1 minute long wait followed by curl command pointing to host and path in Ingress rules.
- **halfway-thru-rolling-deployment-k8s-dashboard.png** - a screenshot of the dashboard during build number 19 deploying a newer image `yaredd/nginx-test-app:18`. Rolling \*\*deployments means uninterrupted service; newer pods are created before old ones are taken down.
- **success-rolling-deployment.png** - testing the deployment via a browser -- Note: deployment test is not robust; had to refresh browser to show current deployment. A test invalidating cache is more accurate.
