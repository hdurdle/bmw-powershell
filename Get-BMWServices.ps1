. ./Get-BMWToken.ps1

$uri = $apiEndpoint + "/api/vehicle/service/v1/$($vin)"

$res = Invoke-RestMethod -Method Get -Uri $uri -Headers $headers -ContentType "application/json"
$res.services