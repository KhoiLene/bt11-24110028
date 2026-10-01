$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession

# 1. Test Home page
$rHome = Invoke-WebRequest -Uri 'http://localhost:8080/' -WebSession $session -UseBasicParsing
Write-Host "1. GET / status: $($rHome.StatusCode)"

# 2. Test Videos list
$rVideos = Invoke-WebRequest -Uri 'http://localhost:8080/videos' -WebSession $session -UseBasicParsing
Write-Host "2. GET /videos status: $($rVideos.StatusCode)"

# 3. Test Video detail SP01
$rDetail = Invoke-WebRequest -Uri 'http://localhost:8080/video/detail?id=SP01' -WebSession $session -UseBasicParsing
Write-Host "3. GET /video/detail?id=SP01 status: $($rDetail.StatusCode)"

# 4. Test Cart page (empty)
$rCartEmpty = Invoke-WebRequest -Uri 'http://localhost:8080/cart' -WebSession $session -UseBasicParsing
Write-Host "4. GET /cart (empty) status: $($rCartEmpty.StatusCode)"

# 5. Add to cart SP01
$rAdd = Invoke-WebRequest -Uri 'http://localhost:8080/cart/add' -Method POST -Body @{ videoId = 'SP01'; quantity = '2' } -WebSession $session -UseBasicParsing
Write-Host "5. POST /cart/add status: $($rAdd.StatusCode)"

# 6. Test Cart page (with item)
$rCartWithItem = Invoke-WebRequest -Uri 'http://localhost:8080/cart' -WebSession $session -UseBasicParsing
Write-Host "6. GET /cart (has item) status: $($rCartWithItem.StatusCode)"

# 7. Check if price or Buy button is present in HTML
if ($rHome.Content -match "MUA HÀNG NGAY") {
    Write-Host "SUCCESS: Home page contains MUA HÀNG NGAY button!"
} else {
    Write-Host "WARNING: Home page does not contain MUA HÀNG NGAY button"
}

if ($rDetail.Content -match "MUA HÀNG NGAY") {
    Write-Host "SUCCESS: Video Detail page contains MUA HÀNG NGAY button!"
} else {
    Write-Host "WARNING: Video Detail page does not contain MUA HÀNG NGAY button"
}

if ($rVideos.Content -match "Mua Hàng") {
    Write-Host "SUCCESS: Videos page contains Mua Hàng button!"
} else {
    Write-Host "WARNING: Videos page does not contain Mua Hàng button"
}
