#!/bin/bash

template_file='hosts.template'

cp ${template_file} hosts.temp

for machine in gw1 store1 store2 store3 store4 store5 cache1 mq1 object-store1 prometheus1 monitor1 apiv1-1 apiv2-1 lmtp1
do
	other_name=`echo ${machine}|tr "-" "_"`
	echo "# Setting ${machine} (${other_name}) into inventory"
	gandi vm info ${machine} > vm_info.tmp
	ipv6=`grep ip6 vm_info.tmp |cut -d':' -f2-40|tr -d " " `
	backend_ip=`grep ip4 vm_info.tmp |grep "192.168"|cut -d':' -f2-40|tr -d " " `
	sed -i -e "s/ip_${other_name}/${ipv6}/g" hosts.temp
	sed -i -e "s/backend_${other_name}/${backend_ip}/" hosts.temp
	echo "ssh root@${ipv6}"
done

rm vm_info.tmp
