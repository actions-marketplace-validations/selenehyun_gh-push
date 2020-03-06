#!/bin/bash

set -e

if [[ -z "$GITHUB_TOKEN" ]]; then
	echo "Set the GITHUB_TOKEN env variable."
	exit 1
fi

if [[ -z "$FILES" ]]; then
	echo "Set the FILES env variable."
	exit 1
fi

if [[ -z "$REPO_FULLNAME" ]]; then
	echo "Set the REPO_FULLNAME env variable."
	exit 1
fi

if [[ -z "$PUBLISH_DIR" ]]; then
	echo "Set the PUBLISH_DIR env variable."
	exit 1
fi

if [[ -z "$BRANCH" ]]; then
	echo "Set the BRANCH env variable."
	exit 1
fi

git clone --depth 1 https://x-access-token:$GITHUB_TOKEN@github.com/$REPO_FULLNAME.git /$REPO_FULLNAME
cp -r ./$PUBLISH_DIR /$REPO_FULLNAME
cd /$REPO_FULLNAME
git config --global user.email "push@no-reply.github.com"
git config --global user.name "GitHub Push Action"

# check commit exists
git add $FILES
git commit -m "GitHub Push"
git push origin $BRANCH