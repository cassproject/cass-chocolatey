#$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName= 'CASS' # arbitrary name for the package, used in messages

#Install CASS
set-service "elasticsearch-service-x64" -startuptype "auto"
stop-service "elasticsearch-service-x64"

$version = Read-Host -Prompt 'Input the version you would like to install (eg 1.5.0 - You can see a list of versions at https://github.com/cassproject/CASS/releases). This installation is compatible with versions 0.5/1.5+.'
cd $env:ChocolateyPackageFolder
git clone --recurse-submodules https://github.com/cassproject/cass -b $version
cd cass
npm install

start-service "elasticsearch-service-x64"
npm run run

#Ensure IIS is installed and configured.
echo "DISM.EXE /online /enable-feature /all /featureName:IIS-WebServerRole /featureName:IIS-WebServer /featureName:IIS-CommonHttpFeatures /featureName:IIS-StaticContent /featureName:IIS-RequestFiltering /featureName:IIS-IPSecurity /featureName:IIS-HttpCompressionStatic /featureName:IIS-HttpCompressionDynamic /featureName:IIS-WebServerManagementTools /featureName:IIS-ManagementScriptingTools /featureName:IIS-ManagementService /featureName:IIS-WMICompatibility /featureName:IIS-WebSockets /featureName:IIS-CertProvider /featureName:IIS-ManagementConsole /featureName:IIS-LegacySnapIn"
echo ""
echo "You will still have to install AAR, URLRewrite, and a Web Farm. We recommend adding a web farm with server port 8080/8080. The above command will install IIS, then 'choco install iis-arr urlrewrite'."
