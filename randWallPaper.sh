#!/bin/bash

##
# Author: Brett Holman
# Date: 3/24/2018
# Summary: Returns a random JPG file's name from the current directory.  Useful for setting random wallpapers.
##


regex="jpg$"
wallPaperNum=0
wallPaperArr=()

# Check pwd for jpgs
for file in $(ls); do
    
    # Check for the file extension ".jpg"
    if [[ $file =~ $regex ]]; then
        wallPaperNum=$((wallPaperNum+1))
        wallPaperArr+=($file)
    fi
done

index=$((RANDOM % $wallPaperNum ))
feh --bg-scale ~/.config/i3/${wallPaperArr[$index]}
