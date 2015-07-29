
#!/bin/bash
#stops and starts bitcoind when restartflag file is set to 1
#does nothing in all other cases
#intended to be run every minute by cronttab:
#* * * * * bash /home/linaro/restartbtc.sh
rsflag=$( < /home/linaro/restartflag)
echo "Flag= $rsflag"
if (( rsflag == 1 )); then
 echo "restarting bitcoind, please wait"
echo 0 > /home/linaro/restartflag
/home/linaro/bitcoin-cli stop
echo "Do not shut down the device until notified"
$x=$(pgrep -f bitcoind)
while [ "$x" !=  "" ]
do
  echo -n "."
  sleep 1s
  x=$(pgrep -f bitcoind)
done
echo "bitcoin has stopped. restart in 5 seconds"
sleep 10s
echo "starting bitcoind, pleese wait 15 min"
/home/linaro/bitcoind -daemon
fi