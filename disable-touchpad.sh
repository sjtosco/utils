#!/bin/bash
#
# Purpose: Toggle synaptic touchpad on/off
# Author: Fazle Arefin
# References: http://ubuntuforums.org/showthread.php?t=1536305
#            https://askubuntu.com/questions/438179/how-can-i-toggle-the-touchpad-depending-on-whether-a-mouse-is-connected
#


#!/bin/bash

device=$(xinput list | grep -iPo 'touchpad.*id=\K\d+')
state=`xinput list-props "$device" | grep "Device Enabled" | grep -o "[01]$"`

if [ $state == '1' ];then
  xinput --disable $device
  notify-send -i emblem-nowrite "Touchpad" "Disabled"
else
  xinput --enable $device
  notify-send -i input-touchpad "Touchpad" "Enabled"
fi
