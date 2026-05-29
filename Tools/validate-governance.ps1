# validate-governance.ps1
#
# Validates that a project repository follows the SDLC governance standards.
# Run from the root of your project repository.
#
# Usage:
#   .\Tools\validate-governance.ps1
#   .\Tools\validate-governance.ps1 -ArchPath "docs/Architecture"
#   .\Tools\validate-governance.ps1 -Strict
#
# Exit codes:
#   0 - passed (warnings may be present)
#   1 - failed (one or more errors)
#
# Policy references:
#   WORK-DONE-POLICY.md  - status table requirement
#   DRIFT-RESOLUTION-POLICY.md  - DFR naming convention
#   DOCUMENTATION-POLICY.md  - DIP requirement

param(
    [string]$ArchPath = "Architecture",
    [switch]$Strict
)

$errors   = [System.Collections.Generic.List[string]]::new()
$warnings = [System.Collections.Generic.List[string]]::new()

function Add-Error   { param([string]$msg) $errors.Add($msg) }
function Add-Warning { param([string]$msg) $warnings.Add($msg) }

# ---- Check 1: DIP.md exists at repo root ----
if (-not (Test-Path "DIP.md")) {
    Add-Error "Missing DIP.md at repository root. See DOCUMENTATION-POLICY.md."
}

# ---- Check 2: Architecture folder exists ----
if (-not (Test-Path $ArchPath)) {
    Add-Warning "Architecture folder not found at '$ArchPath'. Pass -ArchPath to specify a different location."
}

# ---- Helper: check all .md files in a folder for ## Status section ----
function Test-StatusTable {
    param([string]$FolderPath, [string]$DocType, [string]$Filter = "*.md")

    if (-not (Test-Path $FolderPath)) { return }

    Get-ChildItem -Path $FolderPath -Filter $Filter | ForEach-Object {
        $content = Get-Content $_.FullName -Raw -ErrorAction SilentlyContinue
        if ($content -and ($content -notmatch "## Status")) {
            Add-Error "$DocType missing status table: $($_.Name) - See WORK-DONE-POLICY.md."
        }
    }
}

# ---- Check 3: ADRs have status tables and follow naming convention ----
$adrPath = Join-Path $ArchPath "ADRs"
Test-StatusTable -FolderPath $adrPath -DocType "ADR"

if (Test-Path $adrPath) {
    Get-ChildItem -Path $adrPath -Filter "*.md" | Where-Object {
        $_.Name -notmatch "^ADR-\d{3}-"
    } | ForEach-Object {
        Add-Warning "ADR does not follow naming convention ADR-NNN-Name.md: $($_.Name)"
    }
}

# ---- Check 4: Major Decisions have status tables ----
$mdPath = Join-Path $ArchPath "Major-Decisions"
Test-StatusTable -FolderPath $mdPath -DocType "Major Decision"

if (Test-Path $mdPath) {
    Get-ChildItem -Path $mdPath -Filter "*.md" | Where-Object {
        $_.Name -notmatch "^MD-\d{3}-"
    } | ForEach-Object {
        Add-Warning "Major Decision does not follow naming convention MD-NNN-Name.md: $($_.Name)"
    }
}

# ---- Check 5: Drift Reports have status tables and follow naming convention ----
$dfrPath = Join-Path $ArchPath "Drift-Reports"
Test-StatusTable -FolderPath $dfrPath -DocType "Drift Report"

if (Test-Path $dfrPath) {
    Get-ChildItem -Path $dfrPath -Filter "*.md" | Where-Object {
        $_.Name -notmatch "^DFR-\d{3}-"
    } | ForEach-Object {
        Add-Warning "Drift Report does not follow naming convention DFR-NNN-Name.md: $($_.Name)"
    }
}

# ---- Check 6: Roadmaps have status tables ----
$rdmpPath = Join-Path $ArchPath "Roadmap"
Test-StatusTable -FolderPath $rdmpPath -DocType "Roadmap" -Filter "RDMP-*.md"

# ---- Strict mode checks ----
if ($Strict) {

    # Collect all markdown files under Architecture and DIP.md
    $allMd = @()
    if (Test-Path $ArchPath) {
        $allMd = Get-ChildItem -Path $ArchPath -Filter "*.md" -Recurse
    }
    if (Test-Path "DIP.md") { $allMd += Get-Item "DIP.md" }

    # Check: no em dashes
    foreach ($file in $allMd) {
        $content = Get-Content $file.FullName -Raw -ErrorAction SilentlyContinue
        if ($content -and ($content -match '—')) {
            Add-Warning "Em dash found (use hyphen - instead): $($file.Name)"
        }
    }
}

# ---- Report ----
if ($warnings.Count -gt 0) {
    Write-Host ""
    Write-Host "Warnings:" -ForegroundColor Yellow
    foreach ($w in $warnings) {
        Write-Host "  [!] $w" -ForegroundColor Yellow
    }
}

if ($errors.Count -gt 0) {
    Write-Host ""
    Write-Host "Errors:" -ForegroundColor Red
    foreach ($e in $errors) {
        Write-Host "  [x] $e" -ForegroundColor Red
    }
    Write-Host ""
    Write-Host "Validation FAILED. $($errors.Count) error(s)." -ForegroundColor Red
    exit 1
}

Write-Host ""
if ($warnings.Count -gt 0) {
    Write-Host "Validation passed with $($warnings.Count) warning(s)." -ForegroundColor Yellow
} else {
    Write-Host "Validation passed." -ForegroundColor Green
}
exit 0
