#!/bin/bash

ls
echo "$(./SteamTOTPGenerator $SteamAccountSecret)"
./steamcmd.sh +runscript steamscript.txt

