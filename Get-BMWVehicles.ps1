. ./Get-BMWToken.ps1

$uri = $apiEndpoint + "/api/me/vehicles/v2"
$querystring = "?all=true&brand=BM"

$uri += $querystring

$res = Invoke-RestMethod -Method GET -Uri $uri -Headers $headers -ContentType "application/json"
$res
