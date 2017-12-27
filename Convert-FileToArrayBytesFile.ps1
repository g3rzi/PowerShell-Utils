function Convert-FileToArrayBytesFile
{
<#
	.SYNOPSIS
		Author: Eviatar Gerzi (@g3rzi)
			
	.DESCRIPTION


	.PARAMETER FileToConvertPath
		The file you want to convert

	.PARAMETER NewFilePath
		The target file that will contain the text
			
	.EXAMPLE
        	Convert-FileToArrayBytesFile -FileToConvertPath "C:\tmp\1.txt" -NewFilePath "c:\tmp\calc3.txt"

#>

    [CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		[string]$FileToConvertPath,
		[Parameter(Mandatory = $true)]
		[string]$NewFilePath
	)
	
    
    $bytes = [System.IO.File]::ReadAllBytes($FileToConvertPath)
    
    $sb = New-Object -TypeName "System.Text.StringBuilder";

    $prefix = ""
    $sb.Append("@(") | Out-Null
    $bytes | % {
        
        $sb.Append($prefix) | Out-Null
        $prefix = ","
        $sb.Append($_) | Out-Null
    }

    $sb.Append(")") | Out-Null

    $sb.ToString() >> $NewFilePath
}

