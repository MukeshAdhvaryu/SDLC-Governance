#!/usr/bin/env bash
# validate-governance.sh
#
# Validates that a project repository follows the SDLC governance standards.
# Run from the root of your project repository.
#
# Usage:
#   bash Tools/validate-governance.sh
#   bash Tools/validate-governance.sh docs/Architecture
#   bash Tools/validate-governance.sh Architecture --strict
#
# Exit codes:
#   0 - passed (warnings may be present)
#   1 - failed (one or more errors)
#
# Policy references:
#   WORK-DONE-POLICY.md        - status table requirement
#   DRIFT-RESOLUTION-POLICY.md - DFR naming convention
#   DOCUMENTATION-POLICY.md    - DIP requirement

ARCH_PATH="${1:-Architecture}"
STRICT=0
if [[ "$2" == "--strict" || "$1" == "--strict" ]]; then
    STRICT=1
    ARCH_PATH="${1:-Architecture}"
    [[ "$1" == "--strict" ]] && ARCH_PATH="Architecture"
fi

ERRORS=()
WARNINGS=()

add_error()   { ERRORS+=("$1"); }
add_warning() { WARNINGS+=("$1"); }

# ---- Check 1: DIP.md exists at repo root ----
if [ ! -f "DIP.md" ]; then
    add_error "Missing DIP.md at repository root. See DOCUMENTATION-POLICY.md."
fi

# ---- Check 2: Architecture folder exists ----
if [ ! -d "$ARCH_PATH" ]; then
    add_warning "Architecture folder not found at '$ARCH_PATH'. Pass a path as the first argument."
fi

# ---- Helper: check .md files in a folder for ## Status section ----
check_status_tables() {
    local dir="$1"
    local doc_type="$2"
    local pattern="${3:-*.md}"

    [ ! -d "$dir" ] && return

    while IFS= read -r -d '' file; do
        if ! grep -q "## Status" "$file" 2>/dev/null; then
            add_error "$doc_type missing status table: $(basename "$file") - See WORK-DONE-POLICY.md."
        fi
    done < <(find "$dir" -maxdepth 1 -name "$pattern" -print0)
}

# ---- Helper: check naming convention ----
check_naming() {
    local dir="$1"
    local prefix_pattern="$2"
    local doc_type="$3"
    local convention="$4"

    [ ! -d "$dir" ] && return

    while IFS= read -r -d '' file; do
        name=$(basename "$file")
        if ! echo "$name" | grep -qE "$prefix_pattern"; then
            add_warning "$doc_type does not follow naming convention $convention: $name"
        fi
    done < <(find "$dir" -maxdepth 1 -name "*.md" -print0)
}

# ---- Check 3: ADRs ----
check_status_tables "$ARCH_PATH/ADRs" "ADR"
check_naming "$ARCH_PATH/ADRs" "^ADR-[0-9]{3}-" "ADR" "ADR-NNN-Name.md"

# ---- Check 4: Major Decisions ----
check_status_tables "$ARCH_PATH/Major-Decisions" "Major Decision"
check_naming "$ARCH_PATH/Major-Decisions" "^MD-[0-9]{3}-" "Major Decision" "MD-NNN-Name.md"

# ---- Check 5: Drift Reports ----
check_status_tables "$ARCH_PATH/Drift-Reports" "Drift Report"
check_naming "$ARCH_PATH/Drift-Reports" "^DFR-[0-9]{3}-" "Drift Report" "DFR-NNN-Name.md"

# ---- Check 6: Roadmaps ----
check_status_tables "$ARCH_PATH/Roadmap" "Roadmap" "RDMP-*.md"

# ---- Strict mode checks ----
if [ "$STRICT" -eq 1 ]; then

    # Collect all markdown files under Architecture and DIP.md
    ALL_MD=()
    if [ -d "$ARCH_PATH" ]; then
        while IFS= read -r -d '' f; do ALL_MD+=("$f"); done < <(find "$ARCH_PATH" -name "*.md" -print0)
    fi
    [ -f "DIP.md" ] && ALL_MD+=("DIP.md")

    for file in "${ALL_MD[@]}"; do
        name=$(basename "$file")

        # Check for em dashes
        if grep -qP '\x{2014}' "$file" 2>/dev/null; then
            add_warning "Em dash found (use hyphen - instead): $name"
        fi
    done
fi

# ---- Report ----
if [ ${#WARNINGS[@]} -gt 0 ]; then
    echo ""
    echo "Warnings:"
    for w in "${WARNINGS[@]}"; do echo "  [!] $w"; done
fi

if [ ${#ERRORS[@]} -gt 0 ]; then
    echo ""
    echo "Errors:"
    for e in "${ERRORS[@]}"; do echo "  [x] $e"; done
    echo ""
    echo "Validation FAILED. ${#ERRORS[@]} error(s)."
    exit 1
fi

echo ""
if [ ${#WARNINGS[@]} -gt 0 ]; then
    echo "Validation passed with ${#WARNINGS[@]} warning(s)."
else
    echo "Validation passed."
fi
exit 0
