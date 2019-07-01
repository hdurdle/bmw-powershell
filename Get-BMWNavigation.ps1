#Object contains: 

. ./Get-BMWToken.ps1

$uri = $uri = $apiEndpoint + "/api/vehicle/navigation/v1/$($vin)"
$querystring = "?offset=-60"

$uri += $querystring

$res = Invoke-RestMethod -Method Get -Uri $uri -Headers $headers -ContentType "application/json"
$res

