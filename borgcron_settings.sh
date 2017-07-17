#!/bin/sh
# Configure the main settings for borgcron

BACKUP_NAME='good-backup'
BASE_DIR='/home/borg-backup'
REPOSITORY='ssh://user@somewhere.example:22/./dir'
PASSPHRASE_FILE="$BASE_DIR/good-key" #specify the passphrase, if your repo is encrypted
BACKUP_DIRS="/home /etc /srv /var/log /var/mail /var/lib /var/spool /opt /root /usr/local"
COMPRESSION="lz4" # lz4 | zlib,6 | lzma,9

PRUNE_PARAMS="--keep-daily=14 --keep-weekly=8 --keep-monthly=6 --keep-yearly=0"
# for web servers (only disaster recovery:) --keep-daily=7 --keep-weekly=4 --keep-monthly=1 --keep-yearly=0

# optional settings
ARCHIVE_NAME="{hostname}-$BACKUP_NAME-{now:%Y-%m-%d}" # or %Y-%m-%dT%H:%M:%S
ADD_BACKUP_PARAMS="" # --one-file-system for backing up root file dir

SLEEP_TIME="5m" # time, the script should wait until re-attempting the backup after a failed one
REPEAT_NUMS="1 2 3" # = three times
BORG_BIN="borg" # the binary
LAST_BACKUP_DIR="/var/log/borg/last" # the dir, where stats about latest execution are saved
RUN_PID_DIR="/var/run/borg" # dir for "locking" backups

# create installed list
#
# RPM-based:
# dnf list installed > "$BASE_DIR/backup/dnf.list" 2>/dev/null
# rpm -qa > "$BASE_DIR/backup/rpm.list" 2>/dev/null
#
# DEB-based:
# apt list --installed > "$BASE_DIR/backup/apt.list" 2>/dev/null
# dpkg --get-selections > "$BASE_DIR/backup/dpkg.list" 2>/dev/null

# shellcheck disable=SC1091