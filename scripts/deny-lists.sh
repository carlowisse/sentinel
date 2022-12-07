#!/bin/bash

# sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('ADLIST_HERE', 1, 'sentinel');"
# sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINDENY/domains/', 1, 'sentinel');"

## Variables
DOMAINDENY="https://media.githubusercontent.com/media/carlowisse/sentinel-lists/main/lists/domains/deny"
REGEXDENY="https://media.githubusercontent.com/media/carlowisse/sentinel-lists/main/lists/regex/deny"

# ---------------------------------------------------------------------------------------------------- #

## ADOBE
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINDENY/adobe.txt', 1, 'ADOBE');"

## ADVERTISING
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINDENY/ads.txt', 1, 'ADVERTISING');"

## ADULT
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINDENY/adult.txt', 1, 'ADULT');"

## AGENCIES
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINDENY/agencies.txt', 1, 'AGENCIES');"

## AMP HOSTS
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINDENY/amp_hosts.txt', 1, 'AMP HOSTS');"

## ANALYTICS
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINDENY/analytics.txt', 1, 'ANALYTICS');"

## AUTODISCOVER
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINDENY/autodiscover.txt', 1, 'AUTODISCOVER');"

## CLOAK
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINDENY/cloak.txt', 1, 'CLOAK');"

## COMPILED
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINDENY/compiled.txt', 1, 'COMPILED');"

## CONNECTIVITY CHECK
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINDENY/connectivity_check.txt', 1, 'CONNECTIVITY CHECKS');"

## CRYPTO MINERS
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINDENY/crypto_miners.txt', 1, 'CRYPTO MINERS');"

## DOXXING
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINDENY/doxxing.txt', 1, 'DOXXING');"

## GAME SCAMS
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINDENY/game_scams.txt', 1, 'GAME SCAMS');"

## GENERAL
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINDENY/general.txt', 1, 'GENERAL');"

## HATE JUNK
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINDENY/hate_junk.txt', 1, 'HATE & JUNK');"

## MALWARE
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINDENY/malware.txt', 1, 'MALWARE');"

## MIFIT XIAOMI
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINDENY/mifit_xiaomi.txt', 1, 'MIFIT XIAOMI');"

## SCAM SPAM
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINDENY/scam_spam.txt', 1, 'SCAM & SPAM');"

## SMART TVS
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINDENY/smart_tvs.txt', 1, 'SMART TVS');"

## SUSPICIOUS
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINDENY/suspicious.txt', 1, 'SUSPICIOUS');"

## TRACKING TELEMETRY
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINDENY/tracking_telemetry.txt', 1, 'TRACKING & TELEMETRY');"

## TYPO SQUATTING
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINDENY/typo_squatting.txt', 1, 'TYPO SQUATTING');"

# SOCIAL
## DATING SERVICES
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINDENY/social/dating_services.txt', 1, 'DATING SERVICES');"

## FACEBOOK
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINDENY/social/facebook.txt', 1, 'FACEBOOK');"

## INSTAGRAM
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINDENY/social/instagram.txt', 1, 'INSTAGRAM');"

## MESSENGER
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINDENY/social/messenger.txt', 1, 'MESSENGER');"

## REDDIT
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINDENY/social/reddit.txt', 1, 'REDDIT');"

## SKYPE
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINDENY/social/skype.txt', 1, 'SKYPE');"

## SNAPCHAT
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINDENY/social/snapchat.txt', 1, 'SNAPCHAT');"

## TIKTOK
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINDENY/social/tiktok.txt', 1, 'TIKTOK');"

## TWITTER
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINDENY/social/twitter.txt', 1, 'TWITTER');"

## WHATSAPP
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINDENY/social/whatsapp.txt', 1, 'WHATSAPP');"

## YOUTUBE
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINDENY/social/youtube.txt', 1, 'YOUTUBE');"

# ---------------------------------------------------------------------------------------------------- #

## REGEX
# pihole --regex '' --comment 'THING (REGEX)'

# SENTINEL
## ADVERTISING
./apply-regex-list.sh $REGEXDENY/ads.txt

## ADULT
./apply-regex-list.sh $REGEXDENY/adult.txt

## AGGRESSIVE ADS
./apply-regex-list.sh $REGEXDENY/aggressive_ads.txt

## AMP
./apply-regex-list.sh $REGEXDENY/amp.txt

## AUTODISCOVER
./apply-regex-list.sh $REGEXDENY/autodiscover.txt

## COMMON
./apply-regex-list.sh $REGEXDENY/common_regex.txt

## CRYPTO
./apply-regex-list.sh $REGEXDENY/crypto.txt

## G00
./apply-regex-list.sh $REGEXDENY/g00.txt

## GAMBLING
./apply-regex-list.sh $REGEXDENY/gambling.txt

## GAME TRACKERS
./apply-regex-list.sh $REGEXDENY/game_trackers.txt

## GENERAL TRACKING
./apply-regex-list.sh $REGEXDENY/general_tracking_ads.txt

## GOOGLE
./apply-regex-list.sh $REGEXDENY/google.txt

## LG TV
./apply-regex-list.sh $REGEXDENY/lg_tv.txt

## LG WEBOS TV
./apply-regex-list.sh $REGEXDENY/lg_webos_tv.txt

## MALWARE
./apply-regex-list.sh $REGEXDENY/malware.txt

## MMOTTI
./apply-regex-list.sh $REGEXDENY/mmotti.txt

## NON STANDARD ASCII
./apply-regex-list.sh $REGEXDENY/non_standard_ascii.txt

## OTHER TV
./apply-regex-list.sh $REGEXDENY/other_tv.txt

## ROKU
./apply-regex-list.sh $REGEXDENY/roku.txt

## SAMSUNG TV
./apply-regex-list.sh $REGEXDENY/samsung_tv.txt

## SONOS
./apply-regex-list.sh $REGEXDENY/sonos.txt

## TELEMETRY
./apply-regex-list.sh $REGEXDENY/telemetry.txt

## TRACKING, ANALYSIS, ADS & MALWARE
./apply-regex-list.sh $REGEXDENY/tracking_analysis_ads_malware.txt

## VIZIO TV
./apply-regex-list.sh $REGEXDENY/vizio_tv.txt

# SOCIAL
### FACEBOOK
./apply-regex-list.sh $REGEXDENY/social/facebook.txt

### MESSENGER
./apply-regex-list.sh $REGEXDENY/social/messenger.txt

### REDDIT
./apply-regex-list.sh $REGEXDENY/social/reddit.txt

### TIKTOK
./apply-regex-list.sh $REGEXDENY/social/tiktok.txt

### TWITTER
./apply-regex-list.sh $REGEXDENY/social/twitter.txt

### WHATSAPP
./apply-regex-list.sh $REGEXDENY/social/whatsapp.txt

### YOUTUBE
./apply-regex-list.sh $REGEXDENY/social/youtube.txt

# ---------------------------------------------------------------------------------------------------- #