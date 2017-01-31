Clear-Host;
$here = Split-Path -Path $MyInvocation.MyCommand.Path -Parent;
$env:PSModulePath = $env:PSModulePath.Insert(0, (Split-Path -Path $here -Parent) + ';');
$name = $MyInvocation.MyCommand.Name.Split('.')[0];
Import-Module $name -Force;

function Test1 {
	Write-Host "Test 1: Find subpath";
	$item = Get-Item -Path '.\';
	$item.FullName;
	$paths = $item | Find-SubPath -pattern '\\fox\a\b\c\d\e\f\';
	$paths.count;
	$paths;
}

Test1;