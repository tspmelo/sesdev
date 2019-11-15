# Container image that runs your code
FROM opensuse/tumbleweed

RUN zypper --gpg-auto-import-keys ref
RUN zypper -n dup
RUN zypper -n install osc

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh
COPY checkin.sh /checkin.sh
COPY changelog.sh /changelog.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]