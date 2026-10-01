$s = New-Object Microsoft.PowerShell.Commands.WebRequestSession

# 1. Login with lekhoi
$loginRes = Invoke-WebRequest -Uri 'http://localhost:8080/login' -Method POST -Body @{ username = 'lekhoi'; password = '12102006' } -WebSession $s -UseBasicParsing
Write-Host "1. Login lekhoi: $($loginRes.StatusCode)"

# 2. Add product SP02 to cart
$addRes = Invoke-WebRequest -Uri 'http://localhost:8080/cart/add' -Method POST -Body @{ videoId = 'SP02'; quantity = '1' } -WebSession $s -UseBasicParsing
Write-Host "2. Add to cart SP02: $($addRes.StatusCode)"

# 3. View /cart
$cartRes = Invoke-WebRequest -Uri 'http://localhost:8080/cart' -WebSession $s -UseBasicParsing
Write-Host "3. View cart: $($cartRes.StatusCode)"

# 4. View /checkout
$chkView = Invoke-WebRequest -Uri 'http://localhost:8080/checkout' -WebSession $s -UseBasicParsing
Write-Host "4. View checkout: $($chkView.StatusCode)"

# 5. Place COD order
$orderPost = Invoke-WebRequest -Uri 'http://localhost:8080/checkout' -Method POST -Body @{
    customerName = 'Lê Khôi Test';
    phone = '0909123456';
    address = '1 Võ Văn Ngân, TP. Thủ Đức';
    note = 'Giao hàng giờ hành chính COD test';
    paymentMethod = 'COD'
} -WebSession $s -UseBasicParsing -MaximumRedirection 0 -ErrorAction SilentlyContinue
Write-Host "5. Place order status: $($orderPost.StatusCode) -> Location: $($orderPost.Headers.Location)"

# Extract orderId
$loc = $orderPost.Headers.Location
if ($loc -match 'orderId=(\d+)') {
    $orderId = $matches[1]
    Write-Host "Created Order ID: $orderId"

    # 6. View Success Receipt
    $succRes = Invoke-WebRequest -Uri "http://localhost:8080/checkout/success?orderId=$orderId" -WebSession $s -UseBasicParsing
    Write-Host "6. Success Receipt status: $($succRes.StatusCode)"
}

# 7. View Order History
$ordHistory = Invoke-WebRequest -Uri 'http://localhost:8080/orders' -WebSession $s -UseBasicParsing
Write-Host "7. Order History status: $($ordHistory.StatusCode)"

# 8. Test 8 status filters
$statuses = @('Đơn hàng mới', 'Đã xác nhận', 'Chuẩn bị hàng', 'Vận chuyển', 'Giao hàng', 'Đã giao', 'Đơn hàng hủy', 'Đơn hàng hoàn')
foreach ($st in $statuses) {
    $encoded = [System.Web.HttpUtility]::UrlEncode($st)
    $filterRes = Invoke-WebRequest -Uri "http://localhost:8080/orders?status=$encoded" -WebSession $s -UseBasicParsing
    Write-Host "   Filter [$st] status: $($filterRes.StatusCode)"
}

# 9. Admin session
$adminSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$adminLogin = Invoke-WebRequest -Uri 'http://localhost:8080/login' -Method POST -Body @{ username = 'admin'; password = '12102006' } -WebSession $adminSession -UseBasicParsing
Write-Host "8. Admin login status: $($adminLogin.StatusCode)"

# 10. Admin Orders
$adminOrders = Invoke-WebRequest -Uri 'http://localhost:8080/admin/orders' -WebSession $adminSession -UseBasicParsing
Write-Host "9. Admin Orders status: $($adminOrders.StatusCode)"

# 11. Admin Products
$adminProducts = Invoke-WebRequest -Uri 'http://localhost:8080/admin/products' -WebSession $adminSession -UseBasicParsing
Write-Host "10. Admin Products status: $($adminProducts.StatusCode)"
