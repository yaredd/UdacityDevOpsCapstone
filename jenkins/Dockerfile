FROM jenkins/jenkins:lts
MAINTAINER 4oh4

# Derived from https://github.com/getintodevops/jenkins-withdocker (miiro@getintodevops.com)

USER root

# Install the latest Docker CE binaries and add user `jenkins` to the docker group
RUN apt-get update && \
    apt-get -y --no-install-recommends install apt-transport-https \
      ca-certificates \
      curl \
      gnupg2 \
      software-properties-common && \
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" &&\
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
  curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
    add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
      $(lsb_release -cs) \
      stable" && \
   apt-get update && \
   apt-get -y --no-install-recommends install docker-ce && \
   apt-get clean && \
   groupadd -g 127 hostdocker && usermod -aG docker jenkins && sed -e 's/^hostdocker:x:127.*$/hostdocker:x:127:jenkins/' -i /etc/group

# drop back to the regular jenkins user - good practice
USER jenkins
RUN mkdir /var/jenkins_home/.kube && \
  /usr/local/bin/install-plugins.sh junit git git-client ssh-slaves greenballs chucknorris ws-cleanup blueocean blueocean-commons blueocean-config blueocean-dashboard blueocean-events blueocean-git-pipeline blueocean-github-pipeline blueocean-web
