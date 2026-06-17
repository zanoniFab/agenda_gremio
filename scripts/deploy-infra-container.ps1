[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$SenderEmail,

    [Parameter(Mandatory = $true)]
    [string]$RecipientEmail,

    [string]$AwsRegion = "sa-east-1",
    [string]$Environment = "dev",
    [string]$ProjectName = "agenda-gremio",
    [string]$ScheduleExpression = "rate(1 day)",
    [switch]$PlanOnly
)

$ErrorActionPreference = "Stop"

$TerraformDir = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot "..\infra\terraform")).Path
$TerraformImage = "hashicorp/terraform:1.9.8"

function Invoke-TerraformContainer {
    param(
        [Parameter(Mandatory = $true)]
        [string[]]$TerraformArgs
    )

    $DockerArgs = @(
        "run",
        "--rm",
        "--workdir",
        "/workspace",
        "--mount",
        "type=bind,source=$TerraformDir,target=/workspace",
        "-e",
        "AWS_ACCESS_KEY_ID",
        "-e",
        "AWS_SECRET_ACCESS_KEY",
        "-e",
        "AWS_SESSION_TOKEN",
        "-e",
        "AWS_DEFAULT_REGION=$AwsRegion",
        "-e",
        "TF_VAR_aws_region=$AwsRegion",
        "-e",
        "TF_VAR_environment=$Environment",
        "-e",
        "TF_VAR_project_name=$ProjectName",
        "-e",
        "TF_VAR_sender_email=$SenderEmail",
        "-e",
        "TF_VAR_recipient_email=$RecipientEmail",
        "-e",
        "TF_VAR_schedule_expression=$ScheduleExpression",
        $TerraformImage
    )

    & docker @DockerArgs @TerraformArgs
    if ($LASTEXITCODE -ne 0) {
        throw "terraform $($TerraformArgs -join ' ') falhou."
    }
}

Invoke-TerraformContainer -TerraformArgs @("init")
Invoke-TerraformContainer -TerraformArgs @("validate")
Invoke-TerraformContainer -TerraformArgs @("plan", "-out=tfplan")

if ($PlanOnly) {
    Write-Host "Plano Terraform gerado em infra\terraform\tfplan."
    return
}

Invoke-TerraformContainer -TerraformArgs @("apply", "-auto-approve", "tfplan")
