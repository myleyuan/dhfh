#!/bin/bash

echo -e "\e[1;31m请在外网IP上运行此脚本\e[0m"

SR="$(cat /etc/motd | tr -d "{\n,\t}" | cut -d ' ' -f3)"
SC='Huawei'
if [ "$SR" = "$SC" ];then
    echo -e "\e[1;33m"
    read -p "是否安装agent插件[y/n]" -t 6 us
    echo -e "\e[0m"
    if [ "$us" = "y" ] ;then
        cd /usr/local && wget https://telescope-ap-southeast-3.obs.myhuaweicloud.com/scripts/agentInstall.sh && chmod 755 agentInstall.sh && ./agentInstall.sh
        echo -e "\e[1;31m已安装Agent，可以进入华为云网站修复插件，您可以选择进入配置agent ，勾选插件状态为“配置异常”的主机，单击“修复插件配置”，在弹出页面上，单击“一键修复”，完成配置Agent，之后可以监控云服务器\e[0m"
    fi 
fi
sleep 3

djs(){
    n=$[$1+1]
    echo -e "\033[?25l"
    for i in `seq $n`;do
    j=$[$n-$i]
    echo -ne "\e[1;31m$j\r \e[0m"
    sleep 1
    done
    echo -e "\033[?25h"
}
systemctl stop firewalld
yum install zip unzip -y
if [ ! -f "go.sh"];then

wget https://install.direct/go.sh
echo -e "\e[1;33m即将运行go.sh脚本，终止请按Ctrl+c  \e[0m"
else
echo -e "\e[1;31m即将运行go.sh脚本，终止请按Ctrl+c  \e[0m"

fi
djs 5
chmod +x go.sh
./go.sh
systemctl start v2ray

echo -e "\e[1;35m显示v2ray节点信息： \e[0m"
echo -e "\e[1;35maddress:$(curl ifconfig.me)"
echo -e "\e[1;35m$(head -3 /etc/v2ray/config.json | tail -1)" | tr -d " " | tr -d '"' | tr -d ","
echo -e "\e[1;35m$(head -8 /etc/v2ray/config.json | tail -1)" | tr -d " " | tr -d '"' | tr -d ","
echo -e "\e[1;35m$(head -10 /etc/v2ray/config.json | tail -1)" | tr -d " " | tr -d '"' | tr -d ","
echo -e "\e[0m"
sleep 2
echo -e "\e[1;33m检测加速脚本bbr.sh是否存在 \e[0m"
sleep 1.5s
if [ ! -f "bbr.sh"];then
    echo -e "\e[1;33m未检测到加速脚本bbr.sh！ \e[0m"
else
    echo -e "\e[1;33m加速脚本bbr.sh存在，即将开始运行！ \e[0m"   
   djs 5
    chmod +x bbr.sh
    echo y | ./bbr.sh
fi
echo -e "\e[1;31m即将重启服务器，重启后请手动连接服务器 \e[0m"
djs 5
reboot
