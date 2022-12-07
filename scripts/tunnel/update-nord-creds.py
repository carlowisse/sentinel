#!/usr/bin/env python

import fileinput
import glob
import os

os.chdir("/etc/openvpn")

file_list = glob.glob("*.ovpn")

for item in file_list:
    for line in fileinput.input(item, inplace = 1):
        print line.replace("auth-user-pass", "auth-user-pass login.txt"),