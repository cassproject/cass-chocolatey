
stop-service "elasticsearch-service-x64"
rm "$env:CATALINA_HOME\webapps\ROOT.war"
rm "$env:CATALINA_HOME\webapps\root" -Recurse
start-service "elasticsearch-service-x64"