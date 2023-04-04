#!/bin/bash

# sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('ADLIST_HERE', 1, 'sentinel');"
# sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/domains/', 1, 'sentinel');"

### VARIABLES ###
DOMAINS="https://media.githubusercontent.com/media/carlowisse/sentinel-lists/main/lists/domains"
REGEXES="https://media.githubusercontent.com/media/carlowisse/sentinel-lists/main/lists/regexes"

### DOMAINS ###

### ADVERTISING ###
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/ads/ads.txt', 1, 'ADVERTISING');"

### MALWARE ###
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/malware/cloak.txt', 1, 'MALWARE');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/malware/crypto_miners.txt', 1, 'MALWARE');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/malware/doxxing.txt', 1, 'MALWARE');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/malware/game_scams.txt', 1, 'MALWARE');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/malware/hate_junk.txt', 1, 'MALWARE');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/malware/malware.txt', 1, 'MALWARE');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/malware/scam_spam.txt', 1, 'MALWARE');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/malware/suspicious.txt', 1, 'MALWARE');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/malware/typo_squatting.txt', 1, 'MALWARE');"

### OTHER ###
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/other/adult.txt', 1, 'OTHER');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/other/agencies.txt', 1, 'OTHER');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/other/amp_hosts.txt', 1, 'OTHER');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/other/analytics.txt', 1, 'OTHER');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/other/autodiscover.txt', 1, 'OTHER');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/other/common.txt', 1, 'OTHER');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/other/compiled.txt', 1, 'OTHER');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/other/connectivity_check.txt', 1, 'OTHER');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/other/general.txt', 1, 'OTHER');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/other/tracking_telemetry.txt', 1, 'OTHER');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/other/url_shorteners.txt', 1, 'OTHER');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/other/windows_connectivity_test.txt', 1, 'OTHER');"

### SERVICES ###
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/services/adobe.txt', 1, 'SERVICES');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/services/apple_app_store.txt', 1, 'SERVICES');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/services/direct_tv.txt', 1, 'SERVICES');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/services/dropbox.txt', 1, 'SERVICES');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/services/electronicarts.txt', 1, 'SERVICES');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/services/epicgames.txt', 1, 'SERVICES');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/services/kickstarter.txt', 1, 'SERVICES');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/services/mifit_xiaomi.txt', 1, 'SERVICES');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/services/namecheap.txt', 1, 'SERVICES');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/services/netflix.txt', 1, 'SERVICES');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/services/smart_tvs.txt', 1, 'SERVICES');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/services/sonos.txt', 1, 'SERVICES');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/services/stackoverflow.txt', 1, 'SERVICES');"

### SOCIAL ###
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/social/dating_services.txt', 1, 'SOCIAL');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/social/discord.txt', 1, 'SOCIAL');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/social/facebook.txt', 1, 'SOCIAL');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/social/instagram.txt', 1, 'SOCIAL');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/social/messenger.txt', 1, 'SOCIAL');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/social/reddit.txt', 1, 'SOCIAL');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/social/skype.txt', 1, 'SOCIAL');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/social/snapchat.txt', 1, 'SOCIAL');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/social/tiktok.txt', 1, 'SOCIAL');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/social/twitter.txt', 1, 'SOCIAL');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/social/whatsapp.txt', 1, 'SOCIAL');"
sudo sqlite3 /etc/pihole/gravity.db "INSERT OR IGNORE INTO adlist (address, enabled, comment) VALUES ('$DOMAINS/social/youtube.txt', 1, 'SOCIAL');"

### REGEX ###

### ADVERTISING ###
./apply-regex-list.sh $REGEXES/ads/ads.txt
./apply-regex-list.sh $REGEXES/ads/aggressive_ads.txt
./apply-regex-list.sh $REGEXES/ads/general_tracking_ads.txt

### MALWARE ###
./apply-regex-list.sh $REGEXES/malware/malware.txt
./apply-regex-list.sh $REGEXES/malware/tracking_analysis_ads_malware.txt

### OTHER ###
./apply-regex-list.sh $REGEXES/other/adult.txt
./apply-regex-list.sh $REGEXES/other/amp.txt
./apply-regex-list.sh $REGEXES/other/autodiscover.txt
./apply-regex-list.sh $REGEXES/other/cdn.txt
./apply-regex-list.sh $REGEXES/other/common_regex.txt
./apply-regex-list.sh $REGEXES/other/crypto.txt
./apply-regex-list.sh $REGEXES/other/g00.txt
./apply-regex-list.sh $REGEXES/other/gambling.txt
./apply-regex-list.sh $REGEXES/other/game_trackers.txt
./apply-regex-list.sh $REGEXES/other/mmotti.txt
./apply-regex-list.sh $REGEXES/other/non_standard_ascii.txt
./apply-regex-list.sh $REGEXES/other/telemetry.txt

### SERVICES ###
./apply-regex-list.sh $REGEXES/services/amazon.txt
./apply-regex-list.sh $REGEXES/services/apple.txt
./apply-regex-list.sh $REGEXES/services/appletv.txt
./apply-regex-list.sh $REGEXES/services/bilibili.txt
./apply-regex-list.sh $REGEXES/services/binance.txt
./apply-regex-list.sh $REGEXES/services/commbank.txt
./apply-regex-list.sh $REGEXES/services/dailymotion.txt
./apply-regex-list.sh $REGEXES/services/deezer.txt
./apply-regex-list.sh $REGEXES/services/disney.txt
./apply-regex-list.sh $REGEXES/services/ebay.txt
./apply-regex-list.sh $REGEXES/services/epicgames.txt
./apply-regex-list.sh $REGEXES/services/giphy.txt
./apply-regex-list.sh $REGEXES/services/github.txt
./apply-regex-list.sh $REGEXES/services/gmail.txt
./apply-regex-list.sh $REGEXES/services/google.txt
./apply-regex-list.sh $REGEXES/services/hulu.txt
./apply-regex-list.sh $REGEXES/services/imgur.txt
./apply-regex-list.sh $REGEXES/services/lg_tv.txt
./apply-regex-list.sh $REGEXES/services/lg_webos_tv.txt
./apply-regex-list.sh $REGEXES/services/medium.txt
./apply-regex-list.sh $REGEXES/services/minecraft.txt
./apply-regex-list.sh $REGEXES/services/netflix.txt
./apply-regex-list.sh $REGEXES/services/nintendo.txt
./apply-regex-list.sh $REGEXES/services/oculus.txt
./apply-regex-list.sh $REGEXES/services/okru.txt
./apply-regex-list.sh $REGEXES/services/origin.txt
./apply-regex-list.sh $REGEXES/services/other_tv.txt
./apply-regex-list.sh $REGEXES/services/playstation.txt
./apply-regex-list.sh $REGEXES/services/roblox.txt
./apply-regex-list.sh $REGEXES/services/roku.txt
./apply-regex-list.sh $REGEXES/services/samsung_tv.txt
./apply-regex-list.sh $REGEXES/services/sonos.txt
./apply-regex-list.sh $REGEXES/services/spotify.txt
./apply-regex-list.sh $REGEXES/services/steam.txt
./apply-regex-list.sh $REGEXES/services/vizio_tv.txt
./apply-regex-list.sh $REGEXES/services/vkcom.txt
./apply-regex-list.sh $REGEXES/services/weibo.txt
./apply-regex-list.sh $REGEXES/services/xbox.txt
./apply-regex-list.sh $REGEXES/services/youtube.txt

### SOCIAL ###
./apply-regex-list.sh $REGEXES/social/discord.txt
./apply-regex-list.sh $REGEXES/social/facebook.txt
./apply-regex-list.sh $REGEXES/social/instagram.txt
./apply-regex-list.sh $REGEXES/social/messenger.txt
./apply-regex-list.sh $REGEXES/social/pinterest.txt
./apply-regex-list.sh $REGEXES/social/reddit.txt
./apply-regex-list.sh $REGEXES/social/skype.txt
./apply-regex-list.sh $REGEXES/social/slack.txt
./apply-regex-list.sh $REGEXES/social/snapchat.txt
./apply-regex-list.sh $REGEXES/social/telegram.txt
./apply-regex-list.sh $REGEXES/social/tiktok.txt
./apply-regex-list.sh $REGEXES/social/tinder.txt
./apply-regex-list.sh $REGEXES/social/twitch.txt
./apply-regex-list.sh $REGEXES/social/twitter.txt
./apply-regex-list.sh $REGEXES/social/viber.txt
./apply-regex-list.sh $REGEXES/social/vimeo.txt
./apply-regex-list.sh $REGEXES/social/wechat.txt
./apply-regex-list.sh $REGEXES/social/whatsapp.txt
