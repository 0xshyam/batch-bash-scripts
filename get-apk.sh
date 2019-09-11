#!/usr/bin/bash

#small script to install an application from play store on android emulator and then extract apk to the local device 
# and uninstall the application on emulator. Useful when u want to download APKs from play store

check_if_installed(){
temp=$(adb shell pm list packages $1)
if $temp; then 
    {
	echo -ne "."
	sleep 1
    check_if_installed	$1
    }
else
    return 
fi
}

get-apk () { 
echo "[[+]] Opening the package in Play Store by calling the Activity Manager"
adb shell am start -a android.intent.action.VIEW -d "market://details?id=$1" 
echo "[[+]] Waiting for Playstore to open"
sleep 5 # you may need to increase/decrease this based on ur mobile GUI response speed
echo "[[+]] Sending a touch Signal to install"
adb shell input touchscreen tap 700 800 #Trail and error until you find the right X Y Co-ordinates
echo "[[+]] Waiting untill the package is installed"
check_if_installed $1
echo "[[+]] Getting the package location"
file=`adb shell pm path $1|cut -f2 -d:`
echo "[[+]] Downloading the file"
adb pull $file $1.apk
sleep 5
echo "[[+]] Uninstalling the application"
adb shell pm uninstall --user 0 $1
}

get-apk $1
