#Object contains: communitySwitch, modelType, scoreList, lastTripList, lifeTimeList, efficiencyQuotient, characteristicList

. ./Get-BMWToken.ps1

$uri = $apiEndpoint + "/api/vehicle/efficiency/v1/$($vin)"

$res = Invoke-RestMethod -Method Get -Uri $uri -Headers $headers -ContentType "application/json"
$res

