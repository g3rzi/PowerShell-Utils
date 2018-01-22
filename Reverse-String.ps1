function Reverse-String
{
<#
	.SYNOPSIS
		Author: Eviatar Gerzi (@g3rzi)
			
	.DESCRIPTION
		Reverse string.
		Based on articale from Microsoft:
		https://blogs.technet.microsoft.com/heyscriptingguy/2015/11/04/reverse-strings-with-powershell/
		
	.PARAMETER StringToReverse
		The string to reverse

	.EXAMPLE
        	Reverse-String "abc"
		# Output: "cba"
#>

  Param(
    [string]$StringToReverse
  )

  $charArray = $StringToReverse.ToCharArray()
  [array]::Reverse($charArray) | Out-Null
  $reversedString = -join($charArray)
  return $reversedString
}
