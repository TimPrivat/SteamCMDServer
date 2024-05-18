#!/bin/bash

#ONE_TIME_CODE=$(./SteamTOTPGenerator-linux $SteamAccountSecret)
#export ONE_TIME_CODE=$ONE_TIME_CODE


#./steamcmd.sh +force_install_dir /srv/samba/games/Steam +login $STEAM_USERNAME $STEAM_PASSWORD $ONE_TIME_CODE +runscript steamscript.txt

convertIDtoName (){
    local APPID=$1
    local NAME=$(curl https://api.steampowered.com/ISteamApps/GetAppList/v0002/ | jq ".applist.apps | .[] | select(.appid==$APPID).name")

    echo $NAME
}

APP_ID=60
NAME=$(convertIDtoName $APP_ID)
echo "APPID $APP_ID: $NAME"
mkdir /srv/samba/games/Steam/steamapps/common/$NAME


