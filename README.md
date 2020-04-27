# Auto-update and tag your private ACF Pro repository

This script is for keeping a private repo of ACF Pro up to date; automatically tagging the version and committing changes.
Such a repo could then be included in composer dependency management, and might make more sense than running cedaro/satispress, depending on your use case.

1. Do the initial creation of your ACF Pro repo, tag its version, commit and push manually before running this script.
2. Clone this repo alongside your acf repo (so that both share the same parent directory).
3. Edit advanced-custom-fields-pro.config with your license key and git username 
4. Edit advanced-custom-fields-pro-composer.json for your plugin repo as it will be used to overwrite the one you have after each update (you need one to use it as a composer dependency)
5. `chmod +x scripts/advanced-custom-fields-pro.sh`
6. You can then run the script `scripts/advanced-custom-fields-pro.sh`

