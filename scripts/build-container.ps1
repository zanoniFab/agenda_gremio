[CmdletBinding()]
param(
    [string]$ImageName = "agenda-gremio-alert",
    [string]$Tag = "local"
)

$ErrorActionPreference = "Stop"

$RepoRoot = Resolve-Path -LiteralPath (Join-Path $PSScriptRoot "..")
$Image = "${ImageName}:${Tag}"

Push-Location -LiteralPath $RepoRoot
try {
    docker build --file Dockerfile --tag $Image .
    if ($LASTEXITCODE -ne 0) {
        throw "Docker build failed."
    }

    Write-Host "Imagem criada: $Image"
}
finally {
    Pop-Location
}
