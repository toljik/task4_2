#!/bin/bash

if service ntp status | grep "active (running)"  > /dev/null
then
 echo "Running" > /dev/null
else
 echo "NOTICE: ntp is not running" >> /var/mail/root
 service ntp start
fi

if cmp -s /etc/ntp.conf /etc/ntp.conf.bak
then
 echo " vse ok" > /var/mail/root
else
 TEXTIZM=`diff -u0 /etc/ntp.conf.bak /etc/ntp.conf`
 echo "NOTICE: /etc/ntp.conf was changed. Calculated diff:" >> /var/mail/root
 echo "$TEXTIZM"
 cp /etc/ntp.conf.bak /etc/ntp.conf
 service ntp restart
fi
