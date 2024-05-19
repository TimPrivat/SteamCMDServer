#!/bin/bash

main() {

    ALL_GAMES=$(receiveAllOwnedGames)

    for GAME in $ALL_GAMES; do

        APP_ID=$GAME
        RAW_NAME=$(convertIDtoName $APP_ID)
        #Windows cant handle '
        NAME="${RAW_NAME//\'}"
        ONE_TIME_CODE=$(./SteamTOTPGenerator-linux $SteamAccountSecret)
        echo "APPID $APP_ID: $NAME"
        echo "NAME: $NAME"

        DIR_PATH="/srv/samba/games/Steam/steamapps/common/$NAME"
        mkdir -p "$DIR_PATH"
        BASE_PATH=$(pwd)
        ./steamcmd.sh +force_install_dir "$DIR_PATH" +login $STEAM_USERNAME $STEAM_PASSWORD $ONE_TIME_CODE +@sSteamCmdForcePlatformType windows +app_update $APP_ID +quit &&
            cd "$DIR_PATH/steamapps/" &&
            mv *.acf /srv/samba/games/Steam/steamapps/ &&
            cd $BASE_PATH &&
            rm -rf /srv/samba/games/Steam/steamapps/common/$NAME/steamapps

    done

}

receiveAllOwnedGames() {
    local ALL_GAMES=$(curl "https://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=${STEAM_API_KEY}&steamid=${STEAM_ID}&format=json" | jq -r ".response.games[].appid")
    echo $ALL_GAMES
}

convertIDtoName() {
    local APPID=$1
    local NAME=$(curl https://api.steampowered.com/ISteamApps/GetAppList/v0002/ | jq -r ".applist.apps | .[] | select(.appid==$APPID).name")

    echo $NAME
}

main
