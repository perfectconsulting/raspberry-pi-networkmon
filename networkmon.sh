#!/bin/bash

if ifconfig $1 | grep -q "inet addr:" ;
then
        echo "$(date "+%m %d %Y %T") : Ethernet OK"
else
        echo "$(date "+%m %d %Y %T") : Ethernet connection down! Attempting reconnection."
        ifup --force $1
        OUT=$? #save exit status of last command to decide what to do next
        if [ $OUT -eq 0 ] ; then
                STATE=$(ifconfig $1 | grep "inet addr:")
                echo "$(date "+%m %d %Y %T") : Network connection reset. Current state is" $STATE
        else
                echo "$(date "+%m %d %Y %T") : Failed to reset ethernet connection"
        fi
fi
