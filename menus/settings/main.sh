#!/bin/bash
#
# [PlexGuide Menu]
#
# GitHub:   https://github.com/Admin9705/PlexGuide.com-The-Awesome-Plex-Server
# Author:   Admin9705 & Deiteq & Bryde ツ
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
echo 'INFO - @Settings Menu - GDrive Edition' > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh
HEIGHT=16
WIDTH=62
CHOICE_HEIGHT=10
BACKTITLE="Visit https://PlexGuide.com - Automations Made Simple"
TITLE="PG Settings"
MENU="Make Your Selection Choice:"

OPTIONS=(A "Download Path  : Change the DL Path"
         B "Processor      : Enhance Processing Power (RISK)"
         C "Kernel Mods    : Enhance Network Throughput (RISK)"
         D "WatchTower     : Auto-Update Application Manager"
         E "Import Media   : Import Existing Media to GDrive"
         F "Change Time    : Change the Server Time"
         G "TLD Application: Set an App @ Top Level Domain (TLD)"
         H "Server ID      : Change Default Server ID"
         Z "Exit")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
  A)
    echo 'INFO - Selected: 2nd HD Interface' > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh
    bash /opt/plexguide/scripts/baseinstall/harddrive.sh ;;
  B)
    echo 'INFO - Selected: Enhance Processor' > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh
    bash /opt/plexguide/roles/processor/scripts/processor-menu.sh ;;
  C)
    echo 'INFO - Selected: Kernal Mods' > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh
    bash /opt/plexguide/scripts/menus/kernel-mod-menu.sh ;;
  D)
    echo 'INFO - Selected: WatchTower Interface' > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh
    bash /opt/plexguide/roles/watchtower/menus/main.sh ;;
  E)
    echo 'INFO - Selected: 2nd HD Interface' > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh
    bash /opt/plexguide/menus/migrate/main.sh ;;
  F)
    echo 'INFO - Selected: Import Media' > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh
    dpkg-reconfigure tzdata ;;
  G)
    echo 'INFO - Selected: 2nd HD Interface' > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh
    echo "off" > /var/plexguide/tld.control
    ansible-playbook /opt/plexguide/pg.yml --tags tld
    echo ""
    read -n 1 -s -r -p "Containers Must Be Rebuilt! - Press [Any] Key to Continue"
    echo ""
    control=$(cat /var/plexguide/tld.control)
    if [ "$control" == "on" ]; then
      bash /opt/plexguide/roles/tld/scripts/rebuild.sh
    else
      sleep 0.5
      echo ""
      read -n 1 -s -r -p "User Exited! - Press [Any] Key to Continue"
    fi ;;
  H)
    echo 'INFO - Selected: Change Server ID' > /var/plexguide/pg.log && bash /opt/plexguide/roles/log/log.sh
    bash /opt/plexguide/menus/backup-restore/server.sh ;;
  Z)
    clear
    exit 0 ;;
esac
clear
bash /opt/plexguide/menus/settings/main.sh
exit 0
