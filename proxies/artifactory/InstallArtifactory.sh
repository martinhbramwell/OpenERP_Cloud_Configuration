#!/bin/bash

# This script installs artifactory in TomCat.
mkdir -p ~/Downloads
cd ~/Downloads
rm -fr artifactory-2.4.2
#
wget -N http://downloads.sourceforge.net/project/artifactory/artifactory/2.4.2/artifactory-2.4.2.zip
unzip artifactory-2.4.2 artifactory-2.4.2/webapps/artifactory.war
sudo mv artifactory-2.4.2/* /usr/share/tomcat
rm -fr ./artifactory-2.4.2
#
#


