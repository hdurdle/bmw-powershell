. ./Get-BMWToken.ps1

$startAngle = 0
$stepAngle = 10
$width = 1024

$uri = $apiEndpoint + "/api/vehicle/image/v1/$($vin)"
$querystring = "?startAngle=$($startAngle)&stepAngle=$($stepAngle)&width=$($width)"

$uri += $querystring

$res = Invoke-RestMethod -Method Get -Uri $uri -Headers $headers -ContentType "application/json"
$res