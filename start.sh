#!/bin/bash

rm /etc/sysconfig/network-scripts/ifcfg-eth0

chkconfig --add forkexecd
service forkexecd start
chkconfig --add xcp-networkd
service xcp-networkd start
chkconfig --add genptoken
service genptoken start
chkconfig --add squeezed
service squeezed start
chkconfig --add xcp-rrdd
service xcp-rrdd start
chkconfig --add xenopsd-xc
service xenopsd-xc start
chkconfig --add xapi
service xapi start

sleep 30

chkconfig --add xcp-rrdd-plugins
service xcp-rrdd-plugins start
chkconfig --add firstboot
service firstboot start
chkconfig --add perfmon
service perfmon start

. /etc/xensource-inventory
xe pif-scan host-uuid=${INSTALLATION_UUID}
PIF=$(xe pif-list device=eth0 params=uuid --minimal)
xe pif-reconfigure-ip uuid=${PIF} mode=dhcp
xe pif-plug uuid=${PIF}

