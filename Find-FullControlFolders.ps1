
#TODO: make it nicer
$folder = "C:\ProgramData\"

$foldersWithPermissions = New-Object System.Collections.ArrayList
$foldersWithPermissionsAndNoFolders = New-Object System.Collections.ArrayList

$deniedFolders=@()

Get-ChildItem -Recurse -Force -Directory $folder -ErrorAction SilentlyContinue -ErrorVariable +deniedFolders| Where-Object {
    $folderProp = Get-Acl $_.FullName
    foreach ($access in $folderProp.Access) {
        if (($access.FileSystemRights -eq "Write") -and 
            ($access.AccessControlType -eq "Allow") -and
            ($access.IdentityReference -eq "BUILTIN\Users")){
                $foldersWithPermissions.Add($_) | Out-Null
                $dirCount = gci -Directory $_.FullName
                if ($dirCount.Count -eq 0){
                    $foldersWithPermissionsAndNoFolders.Add($_) | Out-Null
                }
            }
    }

}

# https://teusje.wordpress.com/2012/03/12/powershell-list-all-folders-where-access-is-denied/
$foldersWithPermissions | Foreach-Object { Write-Host $_.FullName }
$foldersWithPermissionsAndNoFolders | Foreach-Object { Write-Host $_.FullName }
$errors | Foreach-Object { Write-Host $_ }



