#!/bin/bash

rm /etc/sysconfig/network-scripts/ifcfg-eth0

service forkexecd start
service xcp-networkd start
service genptoken start
service squeezed start
service xcp-rrdd start
service xenopsd-xc start
service xapi start

sleep 30

service xcp-rrdd-plugins start
service firstboot start
service perfmon start

. /etc/xensource-inventory
xe pif-scan host-uuid=${INSTALLATION_UUID}
PIF=$(xe pif-list device=eth0 params=uuid --minimal)
xe pif-reconfigure-ip uuid=${PIF} mode=dhcp
xe pif-plug uuid=${PIF}

