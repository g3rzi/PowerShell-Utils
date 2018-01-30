function Rewrite-File
{
<#
	.SYNOPSIS
		Author: Eviatar Gerzi (@g3rzi)
			
	.DESCRIPTION
        	Just rewrite a given file

	.PARAMETER File
		The original file
			
	.EXAMPLE
        	Rewrite-File -File "C:\tmp\file.txt"
           	Output: [*] File 'C:\tmp\file0.txt' was created !
#>

    [CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		[string]$File
	)
    
    function Build-NewName($fileItem, $count){

        return $fileItem.Directory.FullName + "\" + $fileItem.BaseName + $count + $fileItem.Extension
    }

    if(Test-Path $File){

        $bytes = [System.IO.File]::ReadAllBytes($File)
        
        $fileItem = Get-ChildItem $File
        $count = 0
        
        $newFile = Build-NewName $fileItem $count

        while(Test-Path $newFile){
            $count++
            $newFile = Build-NewName $fileItem $count
        }

        [io.file]::WriteAllBytes($newFile, $bytes)
        Write-Host "[*] File '$($newFile)' was created !"

    }
    else{
        Write-Host "[*] File '$($File)' not exist"
    }
}



