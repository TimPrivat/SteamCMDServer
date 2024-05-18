#!/bin/bash

ONE_TIME_CODE=$(./SteamTOTPGenerator-linux $SteamAccountSecret)
export ONE_TIME_CODE=$ONE_TIME_CODE
echo "One Time Code: $ONE_TIME_CODE"

printenv | grep "ONE_TIME_CODE"


./steamcmd.sh +login $STEAM_USERNAME $STEAM_PASSWORD $ONE_TIME_CODE +runscript steamscript.txt

