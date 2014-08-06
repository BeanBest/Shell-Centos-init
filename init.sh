#!/bin/bash
chkconfig --list|grep on|awk '{print $1}'|grep -v sshd|grep -v rsyslog|grep -v sysstat|grep -v crond|grep -v iptables|grep -v network|grep -v irqbalance >>a.txt
for i in `cat a.txt`; do chkconfig  $i off; done

sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config 
sed -i 's/SELINUXTYPE/#SELINUXTYPE/g' /etc/selinux/config

#echo > /etc/selinux/config
#cat <<EOF >> /etc/selinux/config
#SELINUX=disabled
#EOF

echo > /etc/resolv.conf
cat <<EOF >> /etc/resolv.conf   
nameserver  10.9.240.3
nameserver  10.9.240.6 
EOF

echo > /etc/sysconfig/network-scripts/ifcfg-eth0
cat <<EOF >> /etc/sysconfig/network-scripts/ifcfg-eth0
DEVICE=eth0
TYPE=Ethernet
ONBOOT=yes
NM_CONTROLLED=yes
BOOTPROTO=static
IPADDR=10.9.240.$1
NETMASK=255.255.255.0
GATEWAY=10.9.240.1
EOF

rm -fr a.txt set.sh
