#!/bin/bash

systemctl stop firewalld
yum install zip unzip -y
if [ ! -f go.sh ];then
    wget https://install.direct/go.sh
    echo "即将运行go.sh脚本，终止请按Ctrl+c" 
else
    echo "即将运行go.sh脚本，终止请按Ctrl+c"  
fi
for I in {0..4};do
    J=$[5-$I]
    echo -ne "$J\r"
    sleep 1
done
chmod +x go.sh
./go.sh
systemctl start v2ray
cat /etc/v2ray/config.json
echo "检测加速脚本bbr.sh是否存在"
if [ ! -f bbr.sh ];then
    echo "未检测到加速脚本bbr.sh！"
else
    echo "加速脚本bbr.sh存在，即将开始运行！"
    for I in {0..4};do
        J=$[5-$I]
        echo -ne "$J\r"
        sleep 1
    done
    chmod +x bbr.sh
    ./bbr.sh
fi

