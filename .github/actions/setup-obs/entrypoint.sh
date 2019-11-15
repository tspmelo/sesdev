#!/bin/sh -l

echo "$INPUT_OBS_PROJECT"
echo "$INPUT_OBS_PACKAGE_NAME"
echo "$INPUT_FULL_NAME"

echo "--------------------------------------------------------"
ls /github/home
echo "--------------------------------------------------------"
ls /github/workspace
echo "--------------------------------------------------------"
ls /github/workflow
echo "--------------------------------------------------------"

cat > /root/.config/osc/oscrc << ENDOFFILE
[general]
apiurl = https://api.opensuse.org

[https://api.opensuse.org]
user = $INPUT_OBS_USER
pass = $INPUT_OBS_PASS
email = $INPUT_OBS_EMAIL
ENDOFFILE

cat /root/.config/osc/oscrc

mkdir ~/obs
cd ~/obs
timeout 1s osc co $INPUT_OBS_PROJECT $INPUT_OBS_PACKAGE_NAME
# cd $INPUT_OBS_PROJECT/$INPUT_OBS_PACKAGE_NAME


# bash checkin.sh --existing ~/
# osc status # should now show a new tarball and modified .spec
# # osc diff ceph-iscsi.spec # should show version number change and any other spec file changes from the branch

# # EDITAR

# # osc vc # to update ceph-iscsi.changes (be sure to include bsc#/boo# citations for all relevant bugs)

# # osc ci --noservice # to commit to source OBS project
# osc results
