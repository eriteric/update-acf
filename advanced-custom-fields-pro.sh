#!/bin/bash

# This script is for keeping a private repo of ACF up to date; automatically tagging the version and committing changes.
# Such a repo could then be included in composer dependency management, and might make more sense than running cedaro/satispress, depending on your use case.
# 1. replace <your-acf-pro-id> with your ACF ID
# 2. replace <your-git-username> with your git username/account/url
# 3. Do the initial creation of your repo, tag, commit and push manually before running this script.

# grab variables from config file
source scripts/advanced-custom-fields-pro.config

# remove all files from directory except the git repo
cd ./advanced-custom-fields-pro
git rm -rf .
git clean -fxd
cd ..
# download latest acf and unzip it to the directory (dir already named correctly)
wget -O ./acf-latest.zip "https://connect.advancedcustomfields.com/v2/plugins/download?p=pro&k=$acfprokey"
unzip -o acf-latest.zip -d .
# take out the trash
rm acf-latest.zip

# git commands to finish up
cd ./advanced-custom-fields-pro
# check to see if anything was changed:
if `git status | grep -q "nothing to commit"`; then
  printf "copy composer.json back into repo: \n"
  cp ../scripts/advanced-custom-fields-pro-composer.json composer.json
  # grab version number
  VERSION="$(head acf.php | grep -o 'Version: .*' | cut -f2 -d :)"
  # commit changes and tag
  git add *
  git commit -m "$VERSION"
  git tag $VERSION
  git push -u origin master
  git push --tags
  printf "Plugin updated to $VERSION\n"
  # Single quotes print literal (don't expand variables, and print the double quotes)
  # In order to expand the VERSION variable, the single quote for the line is unquoted, the variable expanded in double quotes, and then the single quote resumed after.
  printf '"'"$gituser"'"/advanced-custom-fields-pro": "'"$VERSION"'",'
else
  # No changes
  cp ../scripts/advanced-custom-fields-pro-composer.json composer.json
  git add *
  printf "Plugin was already up to date \n"
fi

cd ..
