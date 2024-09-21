<#
.SYNOPSIS
	Check the DNS resolution 
.DESCRIPTION
	This PowerShell script measures the DNS resolution speed (using select domains) and prints it.
.EXAMPLE
	PS> ./check-dns.ps1
	DNS resolves 56.5 domains per second
.LINK
	https://github.com/bairdk/PowerShell *not actual location. Example only.
.NOTES
	Author: Kyle Baird | License: CC0
#>
 
try {
	#Write-Progress "Measuring DNS resolution..."
	$table = Import-CSV "$PSScriptRoot/../POWERSHELL/popular-domains-x.csv"
	$numRows = $table.Length
	Write-Host "numRows- $numRows"
	
	$stopWatch = [system.diagnostics.stopwatch]::startNew()
	if ($IsLinux) {
		foreach($row in $table){$nop=dig $row.Domain +short}
	} else {
		foreach($row in $table){$nop=Resolve-DNSName $row.Domain
	}
	[float]$elapsed = $stopWatch.Elapsed.TotalSeconds
	Write-Host "Last row of test- $row.Domain stopwatch= $elapsed"}	

	#Write-Progress -completed "Measuring DNS resolution..."
	$average = [math]::round($numRows / $elapsed, 1)
	if ($average -lt 10.0) {
		Write-Host "DNS resolves $average domains per second only"
	} else {  
		Write-Host "DNS resolves $average domains per second"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}