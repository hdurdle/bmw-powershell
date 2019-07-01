$images = ./Get-BMWImages.ps1
$i = 0
foreach ($url in $images.angleUrls) {
	$url.Url
	Start-BitsTransfer -Source $url.Url -Destination "bmw$($i).png"  -TransferType Download
	$i++
}