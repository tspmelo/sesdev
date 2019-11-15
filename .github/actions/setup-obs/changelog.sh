#!/bin/bash

INPUT_FULL_NAME="Ricardo Dias"
INPUT_OBS_EMAIL="ricardo.dias@suse.com"

input="../../../CHANGELOG.md"
spec="~/obs/$INPUT_OBS_PROJECT/$INPUT_OBS_PACKAGE_NAME/.spec"
changes="~/obs/$INPUT_OBS_PROJECT/$INPUT_OBS_PACKAGE_NAME/sesdev.changes"

# Read the version id
while IFS= read -r line
do
  case "$line" in
    "Version:"*)
      IFS='        ' read -r -a array <<< "$line"
      full_version="${array[1]}"
      break
      ;;
  esac
done < "$spec"

# Read only the semver
IFS='+' read -r -a array <<< "$full_version"
version="${array[0]}"

# Prepare the Changelog
read -r -d '' change << EOM
-------------------------------------------------------------------
$(date -u) - $INPUT_FULL_NAME <$INPUT_OBS_EMAIL>

- Update to $version:
EOM

# Append each change
while IFS= read -r line
do
  case "$line" in
    "## [1.0.3"*) start=1 ;;
    "- "*)
      ${firstString/Suzi/$secondString}
      read -r -d '' change << EOM
$change
${line/- /  + }
EOM
      continue
      ;;
    "## "*) [ -z "$start" ] || break ;;
    * );;
  esac
done < "$input"

# Update the file
echo -e "$change\n\n$(cat $changes)" > $changes
