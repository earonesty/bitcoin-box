#!/bin/bash

#watch the mempool size
#restart if it gets too big
#./bitcoin-cli getmempoolinfo > mempool
#byt=$(cat mempool | jq '.bytes')
#echo "$byt"
#echo "$byt" >> cron.log
#if [ "$byt" -gt "100000000" ]; then
# echo "$(date) mempool is $byt, restarting" >> cron.log
# echo 1 > $HOME/restartflag
# echo 0 > mempool
#fi

#watch device free memory.  
#restart bitcoind if less than 50MB free
#fm=$(free | grep Mem | awk '{print $4/$2 * 1000.0}' | bc)
fm=$(awk '/^-/ {print $4}' <(free -m))
a=$(echo "$fm < 100" | bc)
#fm=$(cat freemem)
echo "$fm" >> cron.log
if [ "$a" -eq "1" ]; then
 echo "$(date) free mem + buffers is $fm, restarting" >> cron.log
 echo 1 > $HOME/restartflag
fi

