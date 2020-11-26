#!/bin/bash

set -o errexit

MY_PROMPT='$ '
MY_YESNO_PROMPT='[Y/n] $ '

grpname="flirimaging"

if [ "$(id -u)" = "0" ]
then
    echo
    echo "This script will assist users in configuring their udev rules to allow"
    echo "access to USB devices. The script will create a udev rule which will"
    echo "add FLIR USB devices to a group called $grpname. The user may also"
    echo "choose to restart the udev daemon. All of this can be done manually as well."
    echo
else
    echo
    echo "This script needs to be run as root, e.g.:"
    echo "sudo configure_spinnaker.sh"
    echo
    exit 0
fi

while :
do
    echo "Enter the name of the user to add to this user group."
    echo -n "$MY_PROMPT"
    read usrname
    if [ "$usrname" = "" ]
    then
        echo "No user name was entered. Would you like to exit?"
        echo -n "$MY_YESNO_PROMPT"
        read confirm
        if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ] || [ "$confirm" = "yes" ] || [ "$confirm" = "Yes" ] || [ "$confirm" = "" ]
        then
            exit 0
        fi
    else
        echo "Is this user name ok?: $usrname"
        echo -n "$MY_YESNO_PROMPT"
        read confirm
        if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ] || [ "$confirm" = "yes" ] || [ "$confirm" = "Yes" ] || [ "$confirm" = "" ]
        then
            break
        fi
    fi
done

echo
echo "Adding user $usrname to group $grpname."
echo "Is this ok?"
echo -n "$MY_YESNO_PROMPT"
read confirm
if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ] || [ "$confirm" = "yes" ] || [ "$confirm" = "Yes" ] || [ "$confirm" = "" ]
then
    groupadd -f $grpname
    usermod -a -G $grpname $usrname
else
    echo
    echo "$usrname was not added to group $grpname.  Please configure your devices manually"
    echo "or re-run this script."
    exit 0
fi

UdevFile="/etc/udev/rules.d/40-flir-spinnaker.rules"

echo "Writing the udev rules file...";
echo "SUBSYSTEM==\"usb\", ATTRS{idVendor}==\"1e10\", GROUP=\"$grpname\"" 1>>$UdevFile

echo "Do you want to restart the udev daemon?"
echo -n "$MY_YESNO_PROMPT"
read confirm
if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ] || [ "$confirm" = "yes" ] || [ "$confirm" = "Yes" ] || [ "$confirm" = "" ]
then
    /etc/init.d/udev restart
else
    echo "Udev was not restarted.  Please reboot the computer for the rules to take effect."
    exit 0
fi

echo "Configuration complete."
echo "A reboot may be required on some systems for changes to take effect."
exit 0
