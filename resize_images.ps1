Add-Type -AssemblyName System.Drawing

$picFolder = "c:\Users\oluwo\Documents\oluwole-oni.github.io\project pic"
$targetWidth = 400
$targetHeight = 300

Get-ChildItem -Path $picFolder -Filter "*.png" | ForEach-Object {
    $imagePath = $_.FullName
    Write-Host "Processing: $($_.Name)"
    
    # Load image
    $img = [System.Drawing.Image]::FromFile($imagePath)
    
    Write-Host "  Original: $($img.Width)x$($img.Height)"
    
    # Calculate new dimensions maintaining aspect ratio
    $newWidth = $targetWidth
    $newHeight = [int]([double]$img.Height * $targetWidth / $img.Width)
    
    if ($newHeight -gt $targetHeight) {
        $newHeight = $targetHeight
        $newWidth = [int]([double]$img.Width * $targetHeight / $img.Height)
    }
    
    Write-Host "  New: $newWidth x $newHeight"
    
    # Create bitmap and graphics
    $bitmap = New-Object System.Drawing.Bitmap($newWidth, $newHeight)
    $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
    $graphics.DrawImage($img, 0, 0, $newWidth, $newHeight)
    
    # Save resized image
    $bitmap.Save($imagePath, [System.Drawing.Imaging.ImageFormat]::Png)
    
    # Cleanup
    $graphics.Dispose()
    $bitmap.Dispose()
    $img.Dispose()
    
    Write-Host "  Saved: $($_.Name)"
}

Write-Host "All images resized successfully!"
