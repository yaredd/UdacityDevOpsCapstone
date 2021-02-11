# Capstone Project for DevOps

## Overview

In this project I will be deploying a Nginx app to a private Kubernetes cluster. I will be using Jenkins for CI/CD, Ansible for deploying the Kubernetes cluster using the [K3s](https://rancher.com/products) implementation.

## Infrastructure Setup

### Jenkins CI/CD

I have used the dockerized Jenkins setup and configured it to use the local `dockerd daemon via the host's `/var/run/docker.sock`.
In addition to the recommended Jenkins plugins, I have install the "Kubernetes-cli" plugin to carryout the Kubernetes integration with Jenkins.
I then setup Jenkins credentials for pushing container images to my [dockerhub](https://hub.docker.com) account.
Jenkinsfile defines the pipeline.

### Kubernetes with K3s

The K3s setup is carried out using Ansible manifest `infra_setup/install-k3s-cluster.yml`. The K3s documentation details how to install a Highly Available Kubernetes infrastructure with an External DB using a containerized [MariaDB](https://hub.docker.com/r/yobasystems/alpine-mariadb/). The resulting Kubernetes cluster will have 2 Masters and 3 Workers/Agents.
`kubectl` is installed and configured to run the Kubernetes Dashboard installation like so:

```
kubectl apply -f infra_setup/kubernetes-dashboard.yml
```
