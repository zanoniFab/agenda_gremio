[CmdletBinding()]
param(
    [string]$ImageName = "agenda-gremio-alert",
    [string]$Tag = "local",
    [string]$SenderEmail = "sender@example.com",
    [string]$RecipientEmail = "recipient@example.com",
    [int]$Port = 9000,
    [switch]$Build
)

$ErrorActionPreference = "Stop"

if ($Build) {
    & (Join-Path $PSScriptRoot "build-container.ps1") -ImageName $ImageName -Tag $Tag
}

$Image = "${ImageName}:${Tag}"

docker run `
    --rm `
    --name agenda-gremio-alert-local `
    --publish "${Port}:8080" `
    --env "SENDER_EMAIL=$SenderEmail" `
    --env "RECIPIENT_EMAIL=$RecipientEmail" `
    $Image
