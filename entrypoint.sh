#!/bin/bash

main() {

    # APP_ID=113200
    # NAME=$(convertIDtoName $APP_ID)
    # ONE_TIME_CODE=$(./SteamTOTPGenerator-linux $SteamAccountSecret)
    # echo "APPID $APP_ID: $NAME"

    # DIR_PATH="/srv/samba/games/Steam/steamapps/common/$NAME"
    # mkdir -p "$DIR_PATH"
    # ./steamcmd.sh +force_install_dir "$DIR_PATH" +login $STEAM_USERNAME $STEAM_PASSWORD $ONE_TIME_CODE +@sSteamCmdForcePlatformType windows +app_update $APP_ID +quit \
    #  && mv "$DIR_PATH/steamapps/appmanifest_$APP_ID.acf" /srv/samba/games/Steam/steamapps/ \
    #  && rm -rf /srv/samba/games/Steam/steamapps/common/$NAME/steamapps
    receiveAllOwnedGames
}

receiveAllOwnedGames() {
    All_GAMES=$(curl https://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=${STEAM_API_KEY}&steamid=${STEAM_ID}&format=json)
    echo "All_GAMES: $All_GAMES" 
}

convertIDtoName() {
    local APPID=$1
    local NAME=$(curl https://api.steampowered.com/ISteamApps/GetAppList/v0002/ | jq -r ".applist.apps | .[] | select(.appid==$APPID).name")

    echo $NAME
}

main
