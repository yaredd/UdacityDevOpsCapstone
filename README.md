# Capstone Project for DevOps

## Overview

In this project I will be deploying a Nginx app to a private Kubernetes cluster. I will be using Jenkins for CI/CD, Ansible for deploying the Kubernetes cluster using the [K3s](https://rancher.com/products) implementation. I am also required to deply to AWS, so I have included notes on deployment to EKS as well.

## Infrastructure Setup

Follwing are two ways to setup Kubernetes; on AWS and on-prem. A `~/kube/config` file is created in both cases; this file will be used in running Jenkins.

### Kubernetes with EKS on AWS

I used the [guid](https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html) to install the `eksctl` tool used to setup EKS. Then run:

```
#> eksctl create cluster \
--name udacity \
--region us-west-1 \
--with-oidc \
--ssh-access \
--ssh-public-key ~/.ssh/id_rsa.pub \
--managed
```

### Kubernetes with K3s on-prem

The K3s setup is carried out using Ansible manifest `infra_setup/install-k3s-cluster.yml`. The K3s documentation details how to install a Highly Available Kubernetes infrastructure with an External DB using a containerized [MariaDB](https://hub.docker.com/r/yobasystems/alpine-mariadb/). The resulting Kubernetes cluster will have 2 Masters and 3 Workers/Agents.
`kubectl` is installed and configured to run the Kubernetes Dashboard installation like so:

```
#> kubectl apply -f infra_setup/kubernetes-dashboard.yml
```

The is an on premise Kubernetes cluster installation. I will be using something similar in production.

### Jenkins CI/CD

I have used the dockerized Jenkins setup and configured it to use the local `dockerd` daemon via the host's `/var/run/docker.sock`. The Dockerfile used to run this container is in the `jenkins` folder.
I then setup Jenkins credentials for pushing container images to my [dockerhub](https://hub.docker.com) account.
`Jenkinsfile` defines the pipeline.

#### Screenshots

- **failing-link-stage.png** - shows the failing linting stage
- **passing-lint-stage.png** - shows the passing linting stage
- **success-deployment-1.png** - build number 17 showing the pods running
- **success-deployment-2.png** - build number 17 showing the deployment test involving a 1 minute long wait followed by curl command pointing to host and path in Ingress rules.
- **halfway-thru-rolling-deployment-k8s-dashboard.png** - a screenshot of the dashboard during build number 19 deploying a newer image `yaredd/nginx-test-app:18`. Rolling deployment means uninterrupted service; newer pods are created before old ones are taken down.
- **success-rolling-deployment.png** - testing the deployment via a browser -- Note: deployment test is not robust; had to refresh browser to show current deployment. A test invalidating cache is more accurate.
- **k8s-pods-rolling-deployment.png** - as part of the deployment test, `kubectl get pods -o wide` is run to attest to the successful deployment by showing the pods created. This is a deployment to a **local Kubernetes cluster** not to a AWS Kubernetes.
- **k8s-pods-AWS.png** - the second of the required screenshot showing pods on AWS.
