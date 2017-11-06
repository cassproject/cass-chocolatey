stop-service "tomcat8"
rm "$env:CATALINA_HOME\webapps\ROOT.war"
rm "$env:CATALINA_HOME\webapps\root" -Recurse
start-service "tomcat8"
