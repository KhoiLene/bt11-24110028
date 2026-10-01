$r1 = Invoke-WebRequest -Uri 'http://localhost:8080/cart' -UseBasicParsing
Write-Host "Cart status: $($r1.StatusCode)"
$r2 = Invoke-WebRequest -Uri 'http://localhost:8080/videos' -UseBasicParsing
Write-Host "Videos status: $($r2.StatusCode)"
$r3 = Invoke-WebRequest -Uri 'http://localhost:8080/admin/orders' -UseBasicParsing -MaximumRedirection 0 -ErrorAction SilentlyContinue
Write-Host "Admin orders status: $($r3.StatusCode)"
