cd $env:ChocolateyPackageFolder
npm run stop
Remove-Item -Path cass -Force -Recurse
