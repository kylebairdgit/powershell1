<#
#call this script example:
#run this if Policy error.This changes the policy for the current session only: Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
#test script
$scriptPath = "C:\Users\kylej\OneDrive\Documents\kyletest\write-to-file.ps1"
$param1 = "C:\Users\kylej\OneDrive\Documents\kyletest\testfile1.txt"

$param2 = "firstCall"
$param3 = "stuff abc"
# Call Script1.ps1 with parameters
& $scriptPath -Param1 $param1 -Param2 $param2 -Param3 $param3

$param2 = "nextCall"
$param3 = "stuff def"
# Call Script1.ps1 with parameters
& $scriptPath -Param1 $param1 -Param2 $param2 -Param3 $param3

$param2 = "nextCall"
$param3 = "stuff ghi"
# Call Script1.ps1 with parameters
& $scriptPath -Param1 $param1 -Param2 $param2 -Param3 $param3

#>


# define 3 params so this script can be called from another script
param (
    [string]$Param1, #file location and name
    [ValidateSet("firstCall","nextCall")]
    [string]$Param2,
    [string]$Param3  #content  
)
$firstCall = "firstCall"
$nextCall = "nextCall"

Write-Host "Parameter 1: $Param1"
Write-Host "Parameter 2: $Param2"
Write-Host "Parameter 3: $Param3"

# Define the file path and the initial content
$filePath = $Param1

# Write the initial content to the new file
if ($Param2 -eq $firstCall){
   $fileExists = Test-Path -Path $filePath 
   if ($fileExists) {
       $input = Read-Host "File already exists.Do you want to overlay existing file? Y/N"
       switch ($input.ToUpper()) {
          "Y" {  }
          "N" {throw "This is a terminating error." }
          default {
              throw "This is a terminating error."
          }
       }

   $Param3 | Out-File -FilePath $filePath
   }
}
elseif ($Param2 -eq $nextCall){
   Add-Content -Path $filePath -Value "$Param3"  
}

