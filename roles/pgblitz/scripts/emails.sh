#!/bin/bash
#
# GitHub:   https://github.com/Admin9705/PlexGuide.com-The-Awesome-Plex-Server
# Author:   Admin9705 & FlickerRate
# URL:      https://plexguide.com
#
# PlexGuide Copyright (C) 2018 PlexGuide.com
# Licensed under GNU General Public License v3.0 GPL-3 (in short)
#
#   You may copy, distribute and modify the software as long as you track
#   changes/dates in source files. Any modifications to our software
#   including (via compiler) GPL-licensed code must also be made available
#   under the GPL along with build & install instructions.
#
#################################################################################
path=/opt/appdata/pgblitz/keys/unprocessed

ls -la $path | awk '{ print $9}' | tail -n +4 > /tmp/pgblitz.emails
rm -r /tmp/pgblitz.emails.list 1>/dev/null 2>&1

while read p; do
  email=$(cat /$path/$p | egrep "client_email")
  email="${email:19}"
  email="${email::-2}"
  echo "$email" >> /tmp/pgblitz.emails.list
done </tmp/pgblitz.emails

clear
echo "Welcome to the PG Blitz - EMail Share Generator"
echo ""
echo "In GDRIVE, share the teamdrive with the following emails:"
echo "NOTE: Only for unprocessed files"
echo ""
cat /tmp/pgblitz.emails.list
echo ""
read -n 1 -s -r -p "Press [ANY] key to continue"

echo "INFO - PGBlitz: Displayed to User the E-Mails" > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh
