#!/bin/bash

# This script runs an Archetype to generate a Maven project.

mkdir -p ~/projects
cd ~/projects
mvn archetype:generate -B \
     -DarchetypeGroupId=org.codehaus.mojo \
     -DarchetypeArtifactId=gwt-maven-plugin \
     -DarchetypeVersion=2.2.0 \
     -DarchetypeRepository=repo1.maven.org \
     -DgroupId=com.warehouseman \
     -DartifactId=firstone \
     -Dversion=4.5.6 \
     -Dpackage=1.2.3 \
     -Dmodule=attempt
 

