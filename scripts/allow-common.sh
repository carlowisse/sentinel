#!/bin/bash
### SENTINEL-LISTS (https://github.com/carlowisse/sentinel-lists) ###

### Variables ###
DOMAINS="https://media.githubusercontent.com/media/carlowisse/sentinel-lists/main/lists/domains"
REGEXES="https://media.githubusercontent.com/media/carlowisse/sentinel-lists/main/lists/regexes"

### DOMAINS ###
./apply-allow-list.sh $DOMAINS/other/common.txt
./apply-allow-list.sh $DOMAINS/other/url_shorteners.txt

### REGEX ###
./apply-allow-regex-list.sh $REGEXES/services/amazon.txt
./apply-allow-regex-list.sh $REGEXES/services/apple.txt
./apply-allow-regex-list.sh $REGEXES/services/ebay.txt
./apply-allow-regex-list.sh $REGEXES/services/epicgames.txt
./apply-allow-regex-list.sh $REGEXES/services/giphy.txt
./apply-allow-regex-list.sh $REGEXES/services/github.txt
./apply-allow-regex-list.sh $REGEXES/services/imgur.txt
./apply-allow-regex-list.sh $REGEXES/services/netflix.txt
./apply-allow-regex-list.sh $REGEXES/services/oculus.txt
./apply-allow-regex-list.sh $REGEXES/services/playstation.txt
./apply-allow-regex-list.sh $REGEXES/services/spotify.txt
./apply-allow-regex-list.sh $REGEXES/services/steam.txt
./apply-allow-regex-list.sh $REGEXES/services/youtube.txt

./apply-allow-regex-list.sh $REGEXES/social/discord.txt
./apply-allow-regex-list.sh $REGEXES/social/messenger.txt
./apply-allow-regex-list.sh $REGEXES/social/reddit.txt
./apply-allow-regex-list.sh $REGEXES/social/slack.txt
./apply-allow-regex-list.sh $REGEXES/social/whatsapp.txt

./apply-allow-regex-list.sh $REGEXES/other/cdn.txt

### !! LET THEM IN !! ###
./apply-allow-regex-list.sh $REGEXES/letthemin/bitwarden.txt
