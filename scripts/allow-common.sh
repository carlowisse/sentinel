#!/bin/bash

## Variables
DOMAINALLOW="https://media.githubusercontent.com/media/carlowisse/sentinel-lists/main/lists/domains/allow"
REGEXALLOW="https://media.githubusercontent.com/media/carlowisse/sentinel-lists/main/lists/regex/allow"

# ---------------------------------------------------------------------------------------------------- #

# SENTINEL (https://github.com/carlowisse/sentinel-lists)

## DOMAINS
### General
./apply-allow-list.sh $DOMAINALLOW/electronicarts.txt
./apply-allow-list.sh $DOMAINALLOW/epicgames.txt
./apply-allow-list.sh $DOMAINALLOW/stackoverflow.txt
./apply-allow-list.sh $DOMAINALLOW/windows_connectivity_test.txt

### Services
./apply-allow-list.sh $DOMAINALLOW/services/apple_app_store.txt
./apply-allow-list.sh $DOMAINALLOW/services/namecheap.txt
./apply-allow-list.sh $DOMAINALLOW/services/netflix.txt

### Social
./apply-allow-list.sh $DOMAINALLOW/social/discord.txt
./apply-allow-list.sh $DOMAINALLOW/social/messenger.txt
./apply-allow-list.sh $DOMAINALLOW/social/youtube.txt

## REGEX
### Services
./apply-allow-regex-list.sh $REGEXALLOW/services/apple.txt
./apply-allow-regex-list.sh $REGEXALLOW/services/binance.txt
./apply-allow-regex-list.sh $REGEXALLOW/services/commbank.txt
./apply-allow-regex-list.sh $REGEXALLOW/services/ebay.txt
./apply-allow-regex-list.sh $REGEXALLOW/services/giphy.txt
./apply-allow-regex-list.sh $REGEXALLOW/services/github.txt
./apply-allow-regex-list.sh $REGEXALLOW/services/google.txt
./apply-allow-regex-list.sh $REGEXALLOW/services/medium.txt
./apply-allow-regex-list.sh $REGEXALLOW/services/netflix.txt
./apply-allow-regex-list.sh $REGEXALLOW/services/psn.txt
./apply-allow-regex-list.sh $REGEXALLOW/services/steam.txt

### Social
./apply-allow-regex-list.sh $REGEXALLOW/social/gmail.txt
./apply-allow-regex-list.sh $REGEXALLOW/social/messenger.txt
./apply-allow-regex-list.sh $REGEXALLOW/social/reddit.txt
./apply-allow-regex-list.sh $REGEXALLOW/social/slack.txt
./apply-allow-regex-list.sh $REGEXALLOW/social/whatsapp.txt
./apply-allow-regex-list.sh $REGEXALLOW/social/youtube.txt

# ---------------------------------------------------------------------------------------------------- #
