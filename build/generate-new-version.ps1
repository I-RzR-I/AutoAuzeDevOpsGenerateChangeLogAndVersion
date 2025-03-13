Param
(
	[Parameter(Mandatory = $true)]
	[string]$vsPath,
	[Parameter(Mandatory = $true)]
	[string]$buildApplicationName
);

$assemblyPath = $vsPath+"\src\GeneralAssemblyInfo.cs"
$finalVersion = "1.0.0.0"
$majorVersion = 1
$buildVersion = 0;
$currentYear = (Get-Date -Format "yy");
$currentMonth = (Get-Date -Format "MM");


function generatedVersionInfo($oldVersion, $newVesrion, $application)
{
	Write-Host "#-------------------------------------------------------------------#";
	Write-Host "#	Application version: ";
	Write-Host "#	$application";
	Write-Host "#-------------------------------------------------------------------#";
	Write-Host "#";
	Write-Host "# 		Old generated version: " $oldVersion;
	Write-Host "#		Current generated version: " $newVesrion;
	Write-Host "#";
	Write-Host "#-------------------------------------------------------------------#";
	Write-Host "";
}


#region Get last build number

#-------------------------------------------------------------------
#	Get last build number
#-------------------------------------------------------------------
$assemblyLastBuildNumber = ((Get-Content $assemblyPath) -match 'AssemblyVersion')
$assemblyLastBuildNumber = $assemblyLastBuildNumber -split ('"')
$assemblyLastBuildNumber = $assemblyLastBuildNumber[1]
$assemblyLastBuildNumbers = $assemblyLastBuildNumber.Split('.')
$currentAssemblyBuildNumber = $assemblyLastBuildNumbers[$assemblyLastBuildNumbers.Length - 1]

if ($currentAssemblyBuildNumber -eq '' -or $currentAssemblyBuildNumber -eq ' ' -or $currentAssemblyBuildNumber -eq '*' -or $assemblyLastBuildNumber.EndsWith(".*"))
{
	$buildVersion = 1;
}
else
{
	$buildVersion = ([int]$assemblyLastBuildNumbers[$assemblyLastBuildNumbers.Length - 1]) + 1
}
#-------------------------------------------------------------------

#endregion Get last build number

#region Build new version number

#-------------------------------------------------------------------
#	Build new version number
#-------------------------------------------------------------------
if (([int]$assemblyLastBuildNumbers[$assemblyLastBuildNumbers.Length - 2]) -ne ([int]$currentMonth))
{
	$buildVersion = 1
}

$finalVersion = $majorVersion.ToString() + "." + $currentYear.ToString() + "." + ([int]$currentMonth).ToString() + "." + $buildVersion.ToString()
#-------------------------------------------------------------------

#endregion Build new version number

#region Set Version new values

#-------------------------------------------------------------------
#	Set Version new values
#-------------------------------------------------------------------
$NewVersion = 'AssemblyVersion("' + $finalVersion + '")';
$NewFileVersion = 'AssemblyFileVersion("' + $finalVersion + '")';
$NewAssemblyInformationalVersion = 'AssemblyInformationalVersion("' + $finalVersion + '")';
#-------------------------------------------------------------------

#endregion Set Version new values

#region Set version in file

(Get-Content $assemblyPath -encoding utf8) |
%{ $_ -replace 'AssemblyVersion\("[0-9]+(\.([0-9]+|\*)){1,3}"\)', $NewVersion } |
%{ $_ -replace 'AssemblyFileVersion\("[0-9]+(\.([0-9]+|\*)){1,3}"\)', $NewFileVersion } |
%{ $_ -replace 'AssemblyInformationalVersion\("[0-9]+(\.([0-9]+|\*)){1,3}"\)', $NewAssemblyInformationalVersion } |
Set-Content $assemblyPath -encoding utf8

generatedVersionInfo $assemblyLastBuildNumber $finalVersion $buildApplicationName;

#endregion Set version in file


return $finalVersion;