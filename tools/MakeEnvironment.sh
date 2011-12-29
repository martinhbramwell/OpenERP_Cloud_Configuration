echo "# Generated file -- run MakeEnvironment.sh to recreate it." > environment
echo "JAVA_HOME=$JAVA_HOME" >> environment
echo "M2_HOME=$M2_HOME" >> environment
echo "MAVEN_HOME=$MAVEN_HOME" >> environment
echo "M2_REPO=$M2_REPO" >> environment
echo "M2=$M2" >> environment
echo "CATALINA_HOME=$CATALINA_HOME" >> environment
echo "TOMCAT_USER=$TOMCAT_USER" >> environment
echo "SRV_CONFIG=$SRV_CONFIG" >> environment
echo "JENKINS_URL=$JENKINS_URL" >> environment
echo "# Path build from some pieces above and existing path." >> environment
echo "PATH=$PATH:$M2_HOME/bin:$JAVA_HOME/bin" >> environment
echo "#" >> environment







