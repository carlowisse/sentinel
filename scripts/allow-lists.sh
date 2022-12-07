#!/bin/bash

## Variables
DOMAINALLOW="https://media.githubusercontent.com/media/carlowisse/sentinel-lists/main/lists/domains/allow"
REGEXALLOW="https://media.githubusercontent.com/media/carlowisse/sentinel-lists/main/lists/regex/allow"

# ---------------------------------------------------------------------------------------------------- #

# SENTINEL (https://github.com/carlowisse/sentinel-lists)
./apply-allow-list.sh $DOMAINALLOW/common.txt
./apply-allow-list.sh $DOMAINALLOW/url_shorteners.txt

# ---------------------------------------------------------------------------------------------------- #