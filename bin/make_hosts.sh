#!/bin/bash

template_file='hosts.template'


cp ${template_file} hosts

for machine in `cat ${template_file}|grep 'ansible_host='|cut -d ' ' -f1`
do
	other_name=`echo ${machine}|tr "-" "_"`
	echo "# Setting ${machine} (${other_name}) into inventory"
	gandi vm info ${machine} > vm_info.tmp
	ipv6=`grep ip6 vm_info.tmp |cut -d':' -f2-40|tr -d " " `
	backend_ip=`grep ip4 vm_info.tmp |grep "192.168"|cut -d':' -f2-40|tr -d " " `
	sed -i -e "s/ip_${other_name}/${ipv6}/g" hosts
	sed -i -e "s/backend_${other_name}/${backend_ip}/" hosts
	echo "ssh root@${ipv6}"
done

rm vm_info.tmp
