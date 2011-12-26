
TOMCAT_USR=jenkins

CLASSPATH="."
CLASSPATH=$CLASSPATH:$JAVA_HOME/lib/tools.jar
CLASSPATH=$CLASSPATH:$CATALINA_HOME/bin/tomcat-juli.jar
CLASSPATH=$CLASSPATH:$CATALINA_HOME/bin/commons-daemon.jar
CLASSPATH=$CLASSPATH:$CATALINA_HOME/bin/bootstrap.jar 

CATALINA_LOGS=$CATALINA_HOME/logs
CATALINA_BIN=$CATALINA_HOME/bin

MAIN_CLASS=org.apache.catalina.startup.Bootstrap
sudo $CATALINA_BIN/jsvc -cp $CLASSPATH -user $TOMCAT_USR -outfile $CATALINA_LOGS/catalina.out -errfile $CATALINA_LOGS/catalina.err $MAIN_CLASS





