[CmdletBinding()]
param(
    [int]$Port = 9000,
    [string]$Payload = '{"source":"local"}'
)

$ErrorActionPreference = "Stop"

$Uri = "http://localhost:$Port/2015-03-31/functions/function/invocations"
Invoke-RestMethod -Method Post -Uri $Uri -Body $Payload -ContentType "application/json"
