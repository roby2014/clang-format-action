#!/bin/bash

set -eu

EXCLUDE_REGEX="$1"

# Set the regex to an empty string regex if nothing was provided
if [[ -z $EXCLUDE_REGEX ]]; then
	EXCLUDE_REGEX="^$"
fi

REPO_FULLNAME=$(jq -r ".repository.full_name" "$GITHUB_EVENT_PATH")

echo "## Initializing git repo..."
git init

echo "### Adding git remote..."
git config --global --add safe.directory /github/workspace
git remote add origin https://x-access-token:$GITHUB_TOKEN@github.com/$REPO_FULLNAME.git

echo "### Getting branch"
BRANCH=${GITHUB_REF#*refs/heads/}

echo "### git fetch $BRANCH ..."
git fetch origin $BRANCH

echo "### Branch: $BRANCH (ref: $GITHUB_REF )"
git checkout $BRANCH

echo "## Configuring git author..."
git config --global user.email "clang@format.com"
git config --global user.name "auto code formatter"

# Ignore workflow files (we may not touch them)
git update-index --assume-unchanged .github/workflows/*

echo "## Running clang-format on C/C++ source"
SRC=$(git ls-tree --full-tree -r HEAD | grep -e "\.\(c\|h\|hpp\|cpp\)\$" | cut -f 2 | grep -v $EXCLUDE_REGEX)

clang-format -style=file -i $SRC

echo "## Commiting files..."
git commit -a -m "apply clang-format" || true

echo "## Pushing to $BRANCH"
git push -u origin $BRANCH
