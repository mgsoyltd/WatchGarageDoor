#!/bin/bash

# bump_version.sh
# Script to bump version numbers for WatchGarageDoor project
# Usage: ./bump_version.sh [major|minor|patch|set] [version]
# Examples:
#   ./bump_version.sh major          # 2.0.0 -> 3.0.0
#   ./bump_version.sh minor          # 2.0.0 -> 2.1.0
#   ./bump_version.sh patch          # 2.0.0 -> 2.0.1
#   ./bump_version.sh set 2.5.3      # Set to specific version
#   ./bump_version.sh build          # Increment build number only

set -e  # Exit on error

PROJECT_FILE="WatchGarageDoor.xcodeproj/project.pbxproj"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if project file exists
if [ ! -f "$PROJECT_FILE" ]; then
    echo -e "${RED}Error: $PROJECT_FILE not found${NC}"
    exit 1
fi

# Get current version
get_current_version() {
    grep -m 1 "MARKETING_VERSION = " "$PROJECT_FILE" | sed 's/.*MARKETING_VERSION = \(.*\);/\1/'
}

# Get current build number
get_current_build() {
    grep -m 1 "CURRENT_PROJECT_VERSION = " "$PROJECT_FILE" | sed 's/.*CURRENT_PROJECT_VERSION = \(.*\);/\1/'
}

CURRENT_VERSION=$(get_current_version)
CURRENT_BUILD=$(get_current_build)

echo -e "${YELLOW}Current version: $CURRENT_VERSION (build $CURRENT_BUILD)${NC}"

# Parse version components
IFS='.' read -r -a VERSION_PARTS <<< "$CURRENT_VERSION"
MAJOR="${VERSION_PARTS[0]}"
MINOR="${VERSION_PARTS[1]}"
PATCH="${VERSION_PARTS[2]}"

# Determine new version based on command
case "$1" in
    major)
        NEW_MAJOR=$((MAJOR + 1))
        NEW_VERSION="$NEW_MAJOR.0.0"
        NEW_BUILD=$((CURRENT_BUILD + 1))
        ;;
    minor)
        NEW_MINOR=$((MINOR + 1))
        NEW_VERSION="$MAJOR.$NEW_MINOR.0"
        NEW_BUILD=$((CURRENT_BUILD + 1))
        ;;
    patch)
        NEW_PATCH=$((PATCH + 1))
        NEW_VERSION="$MAJOR.$MINOR.$NEW_PATCH"
        NEW_BUILD=$((CURRENT_BUILD + 1))
        ;;
    set)
        if [ -z "$2" ]; then
            echo -e "${RED}Error: Please provide a version number (e.g., ./bump_version.sh set 2.5.3)${NC}"
            exit 1
        fi
        # Validate version format
        if [[ ! "$2" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
            echo -e "${RED}Error: Version must be in format x.x.x (e.g., 2.5.3)${NC}"
            exit 1
        fi
        NEW_VERSION="$2"
        NEW_BUILD=$((CURRENT_BUILD + 1))
        ;;
    build)
        NEW_VERSION="$CURRENT_VERSION"
        NEW_BUILD=$((CURRENT_BUILD + 1))
        ;;
    *)
        echo "Usage: $0 [major|minor|patch|set|build] [version]"
        echo ""
        echo "Commands:"
        echo "  major          - Bump major version (x.0.0)"
        echo "  minor          - Bump minor version (x.x.0)"
        echo "  patch          - Bump patch version (x.x.x)"
        echo "  set <version>  - Set specific version (e.g., set 2.5.3)"
        echo "  build          - Increment build number only"
        echo ""
        echo "Current version: $CURRENT_VERSION (build $CURRENT_BUILD)"
        exit 1
        ;;
esac

echo -e "${GREEN}New version: $NEW_VERSION (build $NEW_BUILD)${NC}"

# Ask for confirmation
read -p "Do you want to continue? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Cancelled."
    exit 0
fi

# Create backup
BACKUP_FILE="${PROJECT_FILE}.backup"
cp "$PROJECT_FILE" "$BACKUP_FILE"
echo -e "${YELLOW}Created backup: $BACKUP_FILE${NC}"

# Update all MARKETING_VERSION occurrences
sed -i '' "s/MARKETING_VERSION = ${CURRENT_VERSION};/MARKETING_VERSION = ${NEW_VERSION};/g" "$PROJECT_FILE"

# Update all CURRENT_PROJECT_VERSION occurrences
sed -i '' "s/CURRENT_PROJECT_VERSION = ${CURRENT_BUILD};/CURRENT_PROJECT_VERSION = ${NEW_BUILD};/g" "$PROJECT_FILE"

# Verify changes
VERIFY_VERSION=$(get_current_version)
VERIFY_BUILD=$(get_current_build)

if [ "$VERIFY_VERSION" == "$NEW_VERSION" ] && [ "$VERIFY_BUILD" == "$NEW_BUILD" ]; then
    echo -e "${GREEN}✓ Successfully updated version to $NEW_VERSION (build $NEW_BUILD)${NC}"
    echo -e "${YELLOW}Backup saved to: $BACKUP_FILE${NC}"

    # Show git status
    if git rev-parse --git-dir > /dev/null 2>&1; then
        echo ""
        echo "Git status:"
        git status --short "$PROJECT_FILE"
    fi
else
    echo -e "${RED}Error: Version update verification failed${NC}"
    echo "Expected: $NEW_VERSION (build $NEW_BUILD)"
    echo "Got: $VERIFY_VERSION (build $VERIFY_BUILD)"

    # Restore from backup
    mv "$BACKUP_FILE" "$PROJECT_FILE"
    echo -e "${YELLOW}Restored from backup${NC}"
    exit 1
fi
