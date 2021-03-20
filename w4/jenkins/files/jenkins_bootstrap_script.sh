#!/bin/bash

yum install -y yum-utils

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

yum-config-manager --add-repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo

yum install -y git java jenkins terraform

wget -O /var/lib/jenkins-plugins-manager.jar https://github.com/jenkinsci/plugin-installation-manager-tool/releases/download/2.9.0/jenkins-plugin-manager-2.9.0.jar
java -jar /var/lib/jenkins-plugins-manager.jar --war /usr/lib/jenkins/jenkins.war --plugins configuration-as-code:1.47


# change Jenkins default user and port
# systemctl enable Jenkins
# systemctl start jenkins

# install terraform only if it's not installed yet
# if [[ ! -x /usr/local/sbin/terraform || ! -x /usr/local/sbin/terraform-provider-aws ]];then
#   cd /usr/src
#     wget -c https://releases.hashicorp.com/terraform/0.14.8/terraform_0.14.8_linux_amd64.zip
#     yum install unzip -y
#     unzip terraform_0.14.8_linux_amd64.zip
#     mv terraform* /usr/local/sbin/
#     chmod +x /usr/local/sbin/terraform*
#   cd -
# fi
