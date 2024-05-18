#!/bin/bash

#ONE_TIME_CODE=$(./SteamTOTPGenerator-linux $SteamAccountSecret)
#export ONE_TIME_CODE=$ONE_TIME_CODE

main() {

    APP_ID=60
    NAME=$(convertIDtoName $APP_ID)
    echo "APPID $APP_ID: $NAME"
    DIR_PATH="/srv/samba/games/Steam/steamapps/common/$NAME"
    mkdir -p $DIR_PATH
    ./steamcmd.sh +force_install_dir $DIR_PATH +login $STEAM_USERNAME $STEAM_PASSWORD $ONE_TIME_CODE +@sSteamCmdForcePlatformType windows +app_update $APP_ID +quit

}


convertIDtoName (){
    local APPID=$1
    local NAME=$(curl https://api.steampowered.com/ISteamApps/GetAppList/v0002/ | jq -r ".applist.apps | .[] | select(.appid==$APPID).name")

    echo $NAME
}



main

