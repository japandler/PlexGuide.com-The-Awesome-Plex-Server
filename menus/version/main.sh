#!/bin/bash
#
# [PlexGuide Menu]
#
# GitHub:   https://github.com/Admin9705/PlexGuide.com-The-Awesome-Plex-Server
# Author:   Admin9705 & Deiteq - Flicker-Rate
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
echo 'INFO - @PG Version Selection Menu' > /var/plexguide/pg.log && bash /opt/plexguide/scripts/log.sh

export NCURSES_NO_UTF8_ACS=1

HEIGHT=18
WIDTH=33
CHOICE_HEIGHT=11
BACKTITLE="Visit https://PlexGuide.com - Automations Made Simple"
TITLE="Select A PlexGuide Version"
MENU="Update to PG6 for FURTHER UPDATES"

OPTIONS=(Z "----- Exit Menu -----"
         01 "PG 5 to 6.026")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        Z)
            bash /opt/plexguide/roles/main.sh
echo 'INFO - Selected: Exit Upgrade Menu' > /var/plexguide/pg.log && bash /opt/plexguide/scripts/log.sh
            exit 0
            ;;
        01)
            docker stop traefik2 1>/dev/null 2>&1
            docker stop traefikdeploy 1>/dev/null 2>&1
            docker rm traefik2 1>/dev/null 2>&1
            docker rm traefikdeploy 1>/dev/null 2>&1
            touch /var/plexguide/ask.yes 1>/dev/null 2>&1
            version="6.026" ;;
esac

file="/var/plexguide/ask.yes"
if [ -e "$file" ]
then

touch /var/plexguide/ask.yes 1>/dev/null 2>&1
if ! dialog --stdout --title "Version User Confirmation" \
   --backtitle "Visit https://PlexGuide.com - Automations Made Simple" \
   --yesno "\nDo Want to Install: Version - $version?" 7 50; then
   dialog --title "PG Update Status" --msgbox "\nExiting! User selected to NOT Install!" 0 0
clear
echo 'INFO - Selected Not To Upgrade PG' > /var/plexguide/pg.log && bash /opt/plexguide/scripts/log.sh

sudo bash /opt/plexguide/scripts/message/ending.sh
exit 0
    else
  clear
fi

else
  clear
fi

rm -rf /opt/plexguide 2>/dev/null
wget https://github.com/Admin9705/PlexGuide.com-The-Awesome-Plex-Server/archive/$version.zip -P /tmp
unzip /tmp/$version.zip -d /opt/
mv /opt/PlexG* /opt/plexguide
bash /opt/plexg*/sc*/ins*
rm -r /tmp/$version.zip
touch /var/plexguide/ask.yes 1>/dev/null 2>&1

echo "INFO - Selected: Upgrade to PG $version" > /var/plexguide/pg.log && bash /opt/plexguide/scripts/log.sh

bash /opt/plexguide/scripts/message/ending.sh

## delete this later
