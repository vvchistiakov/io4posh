<#
.SYNOPSIS
.DESCRIPTION
.PARAMETER fileName
.PARAMETER item
.PARAMETER pattern
.INPUTS
.OUTPUTS
.EXAMPLE
#>
function Find-SubPath {
	[CmdletBinding()]
	param(
		[Parameter(mandatory = $true, valueFromPipeline = $true)]
		[Alias('Directory', 'Folder')]
		[System.IO.DirectoryInfo]$item = (Get-Item -Path '.\'),

		[Parameter()]
		[string]$pattern
	)
	
	process {
		$subItems = $pattern.Split('\', [System.StringSplitOptions]::RemoveEmptyEntries);
		[System.Array]::Reverse($subItems);
		$subItems | ForEach-Object -Begin {
			$paths = @();
			$subPath = '';
		} -Process {
			$subPath = [System.String]::Join('\', $_, $subPath);
			$tempPath = [System.String]::Join('\', $item.FullName, $subPath);
			if (Test-Path -Path $tempPath) {
				$paths += $tempPath;
			} 
		} -End {
			return $paths;
		}
	}
}