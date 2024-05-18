#!/bin/bash

ONE_TIME_CODE=$(./SteamTOTPGenerator-linux $SteamAccountSecret)
export ONE_TIME_CODE=$ONE_TIME_CODE
echo "One Time Code: $ONE_TIME_CODE"

printenv | grep "ONE_TIME_CODE"

username=$STEAM_USERNAME
password=$STEAM_PASSWORD

./steamcmd.sh +login $username $password $ONE_TIME_CODE +runscript steamscript.txt

