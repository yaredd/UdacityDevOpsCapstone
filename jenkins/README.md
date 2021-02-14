# Jenkins with Docker and Kubectl

This docker image is based on `jenkins/jenkins-lts`. The container will use the hosts' docker daemon via `/var/run/docker.sock`. It will also need the `kubectl` binary to manage a Kubernetes cluster by mounting the volume containig the `config` file as necessary.
Run the container like so:

```
#> docker run -d --name jenkins-kubectl -v /var/run/docker.sock:/var/run/docker.sock -v /home/yared/.kube/config:/var/jenkins_home/.kube/config -p 3000:8080 jenkins-kubectl
```
