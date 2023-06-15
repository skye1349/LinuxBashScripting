#!/bin/bash
# Author: Skye
# Date: 15/06/2023
# Description: This script will list/delete/rm files older than 90 days
# Modified: 15/06/2023

#list old file
find /home/ubuntu/ps -mtime +90 -exec ls -l {} \;
#delete old file
find /home/ubuntu/ps -mtime +90 -exec rm {} \;
# rename old file
find /home/ubuntu/ps -mtime +90 -exec mv {} {} .old \;
