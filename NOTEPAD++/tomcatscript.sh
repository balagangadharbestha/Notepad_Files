#!/bin/bash

# Set the variables for Tomcat and Java
TOMCAT_VERSION="9.0.75"  # Change this to the desired Tomcat version
JAVA_VERSION="11"       # Change this to the desired Java version

# Update the system packages
sudo yum update -y

# Install OpenJDK
sudo yum install -y java-$JAVA_VERSION-openjdk-devel
#install wget
sudo yum install -y wget

# Download and extract Tomcat
wget https://dlcdn.apache.org/tomcat/tomcat-9/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz
sudo tar -xf apache-tomcat-$TOMCAT_VERSION.tar.gz -C /opt

# Set the environment variables for Tomcat
export CATALINA_HOME="/opt/apache-tomcat-$TOMCAT_VERSION"
export JAVA_HOME="/usr/lib/jvm/java-$JAVA_VERSION-openjdk"

# Make the environment variables permanent
echo "export CATALINA_HOME=\"/opt/apache-tomcat-$TOMCAT_VERSION\"" | sudo tee -a /etc/profile.d/tomcat.sh
echo "export JAVA_HOME=\"/usr/lib/jvm/java-$JAVA_VERSION-openjdk\"" | sudo tee -a /etc/profile.d/tomcat.sh
sudo chmod +x /etc/profile.d/tomcat.sh
source /etc/profile.d/tomcat.sh

# Cleanup
rm apache-tomcat-$TOMCAT_VERSION.tar.gz

# Start Tomcat
$CATALINA_HOME/bin/startup.sh
