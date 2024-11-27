# Usage: ./kickstarter_cleanup.ps1

$confirmation = Read-Host "Confirm cleanup? [y/n]"
if ($confirmation -eq 'n') {
	Write-Host "⚠️ Not cleaned yet!"
	exit
}

Remove-Item docker-compose.local.yml.example
Remove-Item kickstarter.ps1
Remove-Item kickstarter_cleanup.ps1
Remove-Item .git -ErrorAction Ignore

Write-Host "✅ Cleanup successful! 🧹"
