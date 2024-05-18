#!/bin/bash
echo "$(SteamTOTPGenerator $SteamAccountSecret)"
./steamcmd.sh +runscript steamscript.txt

