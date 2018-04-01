#!/bin/bash
d=`dirname $0`
cd $d

apt-get update -y > /dev/null
apt-get install ntp -y > /dev/null

update-rc.d ntp defaults > /dev/null
service ntp start > /dev/null
CONFIG=`cat /etc/ntp.conf | grep -v '^pool' `
echo "$CONFIG" > /etc/ntp.conf
echo "pool ua.pool.ntp.org " >> /etc/ntp.conf
cp /etc/ntp.conf /etc/ntp.conf.bak
service ntp restart

if cat /etc/crontab | grep "task4_2/ntp_verify.sh" > /dev/null
then
 echo "NOTICE: ntp_verify.sh on crontab"
else
 echo "*/5 * * * * $PWD/ntp_verify.sh" | crontab
 echo "NOTICE: ntp_verify.sh added to crontab"
fi
