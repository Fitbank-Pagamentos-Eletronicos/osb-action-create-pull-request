#!/bin/sh
set -e
set -x
if [ -z "$INPUT_WHITELABEL_SOURCE_FOLDER" ]
then
  echo "Source folder must be defined"
  return -1
fi
if [ $INPUT_WHITELABEL_HEAD_BRANCH == "main" ]
then
  echo "Destination head branch can't be 'main'"
  return -1
fi
CLONE_DIR=$(mktemp -d)
echo "Setting git variables"
export GITHUB_TOKEN=$API_TOKEN_GITHUB
git config --global user.email "$INPUT_USER_EMAIL_FITBANK"
git config --global user.name "$INPUT_USER_NAME_FITBANK"
echo "Cloning destination git repository"
git clone "https://$API_TOKEN_GITHUB@github.com/$INPUT_WHITELABEL_REPO.git" "$CLONE_DIR"

echo "Copying contents to git repo"-r $INPUT_USER_NAME_FITBANK
cp -R $INPUT_WHITELABEL_SOURCE_FOLDER "$CLONE_DIR/$INPUT_WHITELABEL_FOLDER"
cd "$CLONE_DIR"
git checkout -b "$INPUT_WHITELABEL_HEAD_BRANCH"

echo "Adding git commit"
git add .
if git status | grep -q "Changes to be committed"
then
  git commit --message "Update from https://github.com/$GITHUB_REPOSITORY/commit/$GITHUB_SHA"
  echo "Pushing git commit"
  git push -u origin HEAD:$INPUT_WHITELABEL_HEAD_BRANCH
  echo "Creating a pull request"
  gh pr create -t $INPUT_WHITELABEL_HEAD_BRANCH \
               -b $INPUT_WHITELABEL_HEAD_BRANCH \
               -B $INPUT_WHITELABEL_BASE_BRANCH \
               -H $INPUT_WHITELABEL_HEAD_BRANCH 
else
  echo "No changes detected"
fi