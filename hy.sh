#!/bin/bash

systemctl stop firewalld
yum install zip unzip -y
if [ ! -f go.sh ];then
    wget https://install.direct/go.sh
    echo -e "\e[1;31m即将运行go.sh脚本，终止请按Ctrl+c \e[0m" 
else
    echo -e "\e[1;31m即将运行go.sh脚本，终止请按Ctrl+c  \e[0m"  
fi
echo -e "\033[?25l"
for I in {0..4};do
    J=$[5-$I]
    echo -ne "\e[1;31m$J\r \e[0m"
    sleep 1
done

echo -e "\033[?25h"
chmod +x go.sh
./go.sh
systemctl start v2ray
echo -e "\e[1;33m检测加速脚本bbr.sh是否存在 \e[0m"
if [ ! -f bbr.sh ];then
    echo -e "\e[1;33m未检测到加速脚本bbr.sh！ \e[0m"
else
    echo -e "\e[1;33m加速脚本bbr.sh存在，即将开始运行！ \e[0m"   
    echo -e "\033[?25l"
    for I in {0..4};do
        J=$[5-$I]
        echo -ne "\e[1;31m$J\r \e[0m"
        sleep 1
    done
    echo -e "\033[?25h"
    chmod +x bbr.sh
    ./bbr.sh
fi

echo -e "\e[1;35m显示v2ray节点信息： \e[0m"

cat /etc/v2ray/config.json
sleep 2
echo -e "\e[1;31m即将重启服务器，重启后请手动连接服务器 \e[0m"
echo -e "\033[?25l"
for I in {0..4};do
    J=$[5-$I]		   
    echo -ne "\e[1;31m$J\r \e[0m"	 
    sleep 1		  
done
echo -e "\033[?25h"
reboot
