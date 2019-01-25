#!/bin/sh
# backup cmis.log
#进入到日志备份文件夹
cd /usr/zhen/logs/log_bak  #the file
#获取今天系统日期
DATE=`date '+%Y%m%d-%H%M'`
#获取昨天日期
LASTYEAR=`TZ=CST+16 date +%Y`
LASTMONTH=`TZ=CST+16 date +%m`
LASTDATE=`TZ=CST+16 date +%Y%m%d`
LAST6HOUR=`TZ=CST+16 date +%Y%m%d%H`
#压缩包命名
SERVICE_ARCHIVE=SERVICE_LOG_BACKUP_$DATE.tar.gz
WEB_ARCHIVE=WEB_LOG_BACKUP_$DATE.tar.gz
service_file="SERVICE_""$DATE.log"
web_file="WEB_""$DATE.log"

#开始备份之前，将备份信息头写入日记文件
echo " " >> log.txt
echo "———————————————–———————————————–" >> log.txt
echo "BACKUP DATE:" $(date +"%y-%m-%d %H:%M:%S") >> log.txt
echo "———————————————–———————————————– " >> log.txt

cp /usr/zhen/logs/ServerManager-Info.log /usr/zhen/logs/log_bak/$service_file

cp /usr/zhen/zhen-web/logs/ServerManager-Info.log /usr/zhen/logs/log_bak/$web_file
#创建备份文件的压缩包
tar zcvf $SERVICE_ARCHIVE $service_file >> log.txt 2>&1

tar zcvf $WEB_ARCHIVE $web_file >> log.txt 2>&1
#判断log备份是否成功
if [[ $? == 0 ]]; then
    #输入备份成功的消息到日记文件
    echo [$SERVICE_ARCHIVE] "Backup Successful!" >> log.txt
    echo [$WEB_ARCHIVE] "Backup Successful!" >> log.txt
	echo " " >> log.txt
    >/usr/zhen/logs/ServerManager-Info.log
    >/usr/zhen/zhen-web/logs/ServerManager-Info.log
    rm -f $service_file
    rm -f $web_file
    #只需保留备份文件的压缩包即可
else
    echo "log for zhen-service Backup Fail!" >> log.txt
    echo "log for zhen-web Backup Fail!" >> log.txt
fi

#输出备份过程结束的提醒消息
echo "Backup Process Done"
