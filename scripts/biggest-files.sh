#!/bin/sh
#Get a list of the 100 biggest files and directories starting in /
du -a / | sort -n -r | head -n 100
