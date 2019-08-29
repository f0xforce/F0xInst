#!/bin/bash
echo "*********************************************"
echo "          F0xSync for AppSync                "
echo "        Written by FoxForce 2019             "
echo "*********************************************"

if [ $# == 0 ]; then
echo "Warning F0xSync need a root access because it use ldid & appinst."
else
echo "Usage: f0xsync filename.ipa."
    exit 1
fi


FILE=$1
if [ -f $FILE ]; then
    echo "* F0xSync: Unpack the archive $FILE..."
	rm -rf "/var/tmp/unpacking/"
    mkdir "/var/tmp/unpacking/"
    unzip "$FILE" -d "/var/tmp/unpacking/" >/dev/null 2>&1
    cd "/var/tmp/unpacking/"
    APPLICATION=$(ls /var/tmp/unpacking/Payload/)
    echo "* F0xSync: Content patch"
    cd "Payload/"
    TEMP=$(ls -1)
    BUNDLENAME=${TEMP%.app}
    cd "$(ls -1)"
    ldid -S "$BUNDLENAME"
    cd /var/tmp/unpacking/
	echo "* F0xSync: Creating an archive"
    zip -qr "/var/tmp/${FILE%.ipa}.ipa" Payload
    echo " F0xSync: Installing ${FILE%.ipa}.ipa..."
    appinst "/var/tmp/${FILE%.ipa}.ipa" >/dev/null 2>&1
    echo "* F0xSync: Installation was successful ${FILE%.ipa}"
    echo "* F0xSync: Cleanup..."
    rm -rf "/var/tmp/unpacking/"
else
   echo ""
fi