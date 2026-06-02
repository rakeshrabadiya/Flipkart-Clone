$images = @{
    'hero-1.jpg'  = 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=1400&auto=format&fit=crop&q=80'
    'hero-2.jpg'  = 'https://images.unsplash.com/photo-1513708925886-3b1f6b8f2f7d?w=1400&auto=format&fit=crop&q=80'
    'hero-3.jpg'  = 'https://images.unsplash.com/photo-1503602642458-232111445657?w=1400&auto=format&fit=crop&q=80'
    'hero-4.jpg'  = 'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?w=1400&auto=format&fit=crop&q=80'
    'hero-5.jpg'  = 'https://images.unsplash.com/photo-1503602642458-232111445657?ixlib=rb-1.2.1&w=1400&auto=format&fit=crop&q=80'

    'promo-1.jpg' = 'https://images.unsplash.com/photo-1600180758890-2c45b1f5a4b9?w=800&auto=format&fit=crop&q=60'
    'promo-2.jpg' = 'https://images.unsplash.com/photo-1542293787938-c9e299b8805a?w=800&auto=format&fit=crop&q=60'
    'promo-3.jpg' = 'https://images.unsplash.com/photo-1523475496153-3d6ccf3a2d6a?w=800&auto=format&fit=crop&q=60'
    'promo-4.jpg' = 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=800&auto=format&fit=crop&q=60'
    'promo-5.jpg' = 'https://images.unsplash.com/photo-1513708925886-3b1f6b8f2f7d?w=800&auto=format&fit=crop&q=60'
    'promo-6.jpg' = 'https://images.unsplash.com/photo-1503602642458-232111445657?w=800&auto=format&fit=crop&q=60'
}

$dir = Join-Path -Path $PSScriptRoot -ChildPath 'images'
if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }

foreach ($name in $images.Keys) {
    $url = $images[$name]
    $out = Join-Path -Path $dir -ChildPath $name
    try {
        Invoke-WebRequest -Uri $url -OutFile $out -UseBasicParsing -ErrorAction Stop
        Write-Host "Saved $out"
    }
    catch {
        Write-Host "Failed to download $name from $url — using placeholder fallback"
        $fallback = "https://picsum.photos/seed/$([System.Uri]::EscapeDataString($name))/800/600"
        try {
            Invoke-WebRequest -Uri $fallback -OutFile $out -UseBasicParsing -ErrorAction Stop
            Write-Host "Saved fallback $out"
        }
        catch {
            Write-Host "Fallback also failed for $name:" $_
        }
    }
}
