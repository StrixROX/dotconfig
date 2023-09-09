#!/usr/bin/env bash

##############################
# Pre-requisites
##############################
# - The brightness interface should be writable by the user.
##############################

##############################
# HOW-TO
# (Ref: https://wiki.archlinux.org/title/backlight#ACPI)
##############################
# - Add the user to "video" group.
#	`gpasswd -a [username] video`
#
# - Create the following udev rule.
#
#	/etc/udev/rules.d/backlight.rules
#	------------------------------
#	ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chgrp video $sys$devpath/brightness", RUN+="/bin/chmod g+w $sys$devpath/brightness"
# - Re-login
###############################

ACPI_INTERFACE="/sys/class/backlight/intel_backlight"

get_brightness_percent() {
	local max_brightness=$(cat "${ACPI_INTERFACE}/max_brightness")
	local current_brightness=$(cat "${ACPI_INTERFACE}/brightness")
	local brightness_percent=$(( $(( $current_brightness*100 ))/$max_brightness ))

	echo $brightness_percent
}

increment() {
	local max_brightness=$(cat "${ACPI_INTERFACE}/max_brightness")
	local new_brightness_percent=$(( $(get_brightness_percent)+$1 ))
	local new_brightness=$(( $(( $new_brightness_percent * $max_brightness ))/100 ))

	if [ $new_brightness_percent -le 100 ]; then
		echo $new_brightness > "${ACPI_INTERFACE}/brightness"
		echo $new_brightness_percent
	else
		echo "Invalid argument"
	fi
}

decrement() {
	echo $(increment -$1)
}

if [[ $1 == "" || $1 == "current" ]]; then
	echo $(get_brightness_percent)%
elif [ $1 == "inc" ]; then
	increment $2
elif [ $1 == "dec" ]; then
	decrement $2
fi
