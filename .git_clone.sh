#!/usr/bin/bash

git="git clone https://github.com/"
#git="url/"
user="$1"
rep="$2"
git="$git$user/$rep.git"
$git
cd $PWD/$rep
