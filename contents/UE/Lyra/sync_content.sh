#!/bin/bash

cd `dirname $0`

if [ -z $1 ]; then
    echo "Usage:"
    echo "    sync.sh \"F:\workspace\LyraStarterGame\""
    exit 1
fi

Marketplace=`cygpath $1`
[[ "$Marketplace" != */ ]] && Marketplace="$Marketplace/"
find $Marketplace -type d -name "Content" | awk -v pos=${#Marketplace} '{print "cp -ar", $0, "." substr($0, pos)}' | bash
