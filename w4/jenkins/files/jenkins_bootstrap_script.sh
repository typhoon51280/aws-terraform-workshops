#!/bin/bash

yum install -y yum-utils

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum-config-manager --add-repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
yum-config-manager --enable jenkins

yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
yum-config-manager --enable hashicorp

yum install -y git java jenkins terraform

sed "s/^JENKINS_JAVA_OPTIONS=.*/JENKINS_JAVA_OPTIONS=\"-Djava.awt.headless=true -Djenkins.install.runSetupWizard=false\"/g" -i /etc/sysconfig/jenkins
sed "s/^JENKINS_PORT=.*/JENKINS_PORT=\"8000\"/g" -i /etc/sysconfig/jenkins

wget -O /var/lib/jenkins/jenkins-plugins-manager.jar "https://github.com/jenkinsci/plugin-installation-manager-tool/releases/download/2.9.0/jenkins-plugin-manager-2.9.0.jar"
sh -c 'java -jar /var/lib/jenkins/jenkins-plugins-manager.jar --war /usr/lib/jenkins/jenkins.war --verbose -d /var/lib/jenkins/plugins --plugins configuration-as-code job-dsl'

chown -R jenkins.jenkins /var/lib/jenkins

# change Jenkins default user and port
systemctl enable jenkins
systemctl start jenkins
