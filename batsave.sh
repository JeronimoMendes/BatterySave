#!/usr/bin/bash

command="$1"
state="$( cat /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode )"

if [[ $state == "1" ]];
then
	mode="ON"
else
	mode="OFF"
fi

if [[ $command == "on" ]];
then
	# Check if it is OFF
	if [[ $mode == "OFF" ]];
	then
		# Turn on battery save mode
		sudo sh -c "echo 1 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"
		echo "Battery save turned ON!"
	else 
		# No need to turn it on if it already is
		echo "Battery save already turned ON!"
	fi

elif [[ $command == "off" ]];
then
	if [[ $mode == "ON" ]];
	then
		# Turn off battery save mode
		sudo sh -c "echo 0 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"
		echo "Battery save turned OFF!"
	else
		echo "Battery save already turned OFF!"
	fi

else 
	# Print usage and current status
	echo "Usage:"
	echo "batsave on|off|help"
	echo "Current status:"
	echo "Battery save is $mode"
fi


