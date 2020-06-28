#!/bin/bash

systemctl stop firewalld
yum install zip unzip -y
if [ ! -f go.sh ];then
    wget https://install.direct/go.sh
    echocolor red "即将运行go.sh脚本，终止请按Ctrl+c" 
else
    echocolor red "即将运行go.sh脚本，终止请按Ctrl+c"  
fi
echo -e "\033[?25l"
for I in {0..4};do
    J=$[5-$I]
    echo -ne "$J\r"
    sleep 1
done

echo -e "\033[?25h"
chmod +x go.sh
./go.sh
systemctl start v2ray
echocolor yellow "检测加速脚本bbr.sh是否存在"
if [ ! -f bbr.sh ];then
    echocolor yellow "未检测到加速脚本bbr.sh！"
else
    echocolor yellow "加速脚本bbr.sh存在，即将开始运行！"   
    echo -e "\033[?25l"
    for I in {0..4};do
        J=$[5-$I]
        echo -ne "$J\r"
        sleep 1
    done
    echo -e "\033[?25h"
    chmod +x bbr.sh
    ./bbr.sh
fi

echocolor purple "显示v2ray节点信息："

cat /etc/v2ray/config.json
sleep 2
echocolor red "即将重启服务器，重启后请手动连接服务器"
echo -e "\033[?25l"
for I in {0..4};do
    J=$[5-$I]		   
    echo -ne "$J\r"		 
    sleep 1		  
done
echo -e "\033[?25h"
reboot
