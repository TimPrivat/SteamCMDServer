#!/bin/bash

ls
echo "$(./SteamTOTPGenerator-linux $SteamAccountSecret)"
./steamcmd.sh +runscript steamscript.txt

