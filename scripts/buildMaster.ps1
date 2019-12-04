[CmdletBinding()]
param 
(
	[string] $msbuild = $env:MSBUILD
)

if ([string]::IsNullOrEmpty($msbuild) -or !(Test-Path $msbuild))
{
	$vswhere = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"
	if (!(Test-Path $vswhere)) {
		throw "vswhere.exe could not be found."
	}

	#Search for MSBuild, preferable from Build Tools
	$msbuild = &$vswhere -latest -requires Microsoft.Component.MSBuild -products * -find MSBuild\**\Bin\MSBuild.exe | select-object -first 1
}
&$msbuild $PSScriptRoot\..\DotnetCoreConsole\DotnetCoreConsole.sln /m /nr:false
