#!/bin/sh
find /usr/zhen/logs/log_bak/ -mtime +30 -name "*.tar.gz" -exec rm -rf {} \;
find /usr/zhen/zhen-web/logs/ -mtime +30 -name "*.out" -exec rm -rf {} \;
