#!/bin/sh

killall mbsync &>/dev/null
mbsync -a -q
sleep 20
killall mbsync &>/dev/null
mbsync -a -q
sleep 20
killall mbsync &>/dev/null
mbsync -a -q
