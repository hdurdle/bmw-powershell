. ./BMWConfig.ps1

$uri = $authEndpoint + "/gcdm/oauth/authenticate"

$postParams = @{
 "client_id" = "$client_id";
 "redirect_uri" = "https://www.bmw-connecteddrive.com/app/static/external-dispatch.html";
 "response_type" = "token";
 "scope" = "authenticate_user fupo";
 "state" = "FOOBAR";
 "locale" = "GB-en";
 "username" = "$email";
 "password" = "$password";
 "Accept" = "application/json"
}

$headers =  @{
  "Accept"="application/json";
  "Referer"="https://customer.bmwgroup.com/one/signin.html?client_id=$client_id&redirect_uri=https:%2F%2Fwww.bmw-connecteddrive.com%2Fapp%2Fstatic%2Fexternal-dispatch.html&response_type=token&scope=authenticate_user%20fupo&state=FOOBAR&locale=GB-en"; 
  "Origin"="https://customer.bmwgroup.com"; 
  "User-Agent"="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36"
 }

$haveToken = $false

if (Test-Path .\bmw.token) {
    $token_info = Get-Content .\bmw.token | ConvertFrom-Json
	$expiry = Get-Date $token_info.expiry
	if ((Get-Date) -lt $expiry) {
		$haveToken = $true
	}
}

if (!$haveToken) {
	Write-Host "Updating token."
	Add-Type -AssemblyName System.Web
	$res = Invoke-WebRequest -Method "POST" -Uri $uri -Body $postParams -Headers $headers -MaximumRedirection 0 -ErrorAction Ignore
	$url = $res.Headers.Location -replace '#','?'
	$qS = [System.Uri]$url
	$ParsedQueryString = [System.Web.HttpUtility]::ParseQueryString($qS.Query)
	$token = $ParsedQueryString["access_token"]
	$expires_in = $ParsedQueryString["expires_in"]
	$now = Get-Date
	$expiry = $now.AddSeconds($expires_in)
	$expiry = Get-Date $expiry -Format "o"
	$token_info = @{
	  "token" = $token;
	  "expiry" = $expiry;
	} | ConvertTo-Json
	$token_info | Out-File "bmw.token"
} else {
	Write-Host "Reusing token."
}

$headers = @{}
$headers.Add("Authorization","Bearer $($token_info.token)" ) | Out-Null
