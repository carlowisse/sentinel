# Pi-Hole Commands

### Add To Black Regex
```bash
pihole --regex "$DOMAIN" --comment "$COMMENT" -nr
```

### Add To White Regex
```bash
pihole --white-regex "$DOMAIN" --comment "$COMMENT" -nr
```

### Add To Whitelist
```bash
pihole -w "$DOMAIN" --comment "$COMMENT" -nr
```

### Add To Blacklist
```bash
pihole -b "$DOMAIN" --comment "$COMMENT" -nr
```

### Add ADList
```bash
sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (address, enabled, comment) VALUES ('$URL', 1, '$COMMENT');"
```
