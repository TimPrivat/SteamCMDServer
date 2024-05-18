#!/bin/bash

ONE_TIME_CODE=$(./SteamTOTPGenerator-linux $SteamAccountSecret)
export ONE_TIME_CODE=$ONE_TIME_CODE
echo "One Time Code: $ONE_TIME_CODE"

printenv | grep "ONE_TIME_CODE"


./steamcmd.sh +set_steam_guard_code $ONE_TIME_CODE +login $STEAM_USERNAME $STEAM_PASSWORD +runscript steamscript.txt

