#$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName= 'CASS' # arbitrary name for the package, used in messages

#Install CASS
set-service "elasticsearch-service-x64" -startuptype "auto"
set-service "Tomcat8" -startuptype "auto"
stop-service "elasticsearch-service-x64"
stop-service "Tomcat8"

$version = Read-Host -Prompt 'Input the version you would like to install (eg 1.2.24 - You can see a list of versions at https://github.com/cassproject/CASS/releases)'

rm "$env:CATALINA_HOME\webapps\root.war"
rm "$env:CATALINA_HOME\webapps\cass.war"
rm "$env:CATALINA_HOME\webapps\ROOT" -Recurse
$url = "https://github.com/cassproject/CASS/releases/download/$version/cass.war"
$output = "$env:CATALINA_HOME\webapps\ROOT.war"
Start-BitsTransfer -Source $url -Destination $output

start-service "elasticsearch-service-x64"
start-service "Tomcat8"

#Ensure IIS is installed and configured.
echo "DISM.EXE /online /enable-feature /all /featureName:IIS-WebServerRole /featureName:IIS-WebServer /featureName:IIS-CommonHttpFeatures /featureName:IIS-StaticContent /featureName:IIS-RequestFiltering /featureName:IIS-IPSecurity /featureName:IIS-HttpCompressionStatic /featureName:IIS-HttpCompressionDynamic /featureName:IIS-WebServerManagementTools /featureName:IIS-ManagementScriptingTools /featureName:IIS-ManagementService /featureName:IIS-WMICompatibility /featureName:IIS-WebSockets /featureName:IIS-CertProvider /featureName:IIS-ManagementConsole /featureName:IIS-LegacySnapIn"
echo ""
echo "You will still have to install AAR, URLRewrite, and a Web Farm. We recommend adding a web farm with server port 8080/8080. The above command will install IIS, then 'choco install iis-arr urlrewrite'."
