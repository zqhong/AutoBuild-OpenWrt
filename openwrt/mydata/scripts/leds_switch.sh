#!/bin/bash

# 晚上22点后关闭路由器的灯
# 添加 cron 定时任务：
## 0 22 * * * /bin/ash /mydata/scripts/leds_switch.sh
## 0 9 * * * /bin/ash /mydata/scripts/leds_switch.sh
# 参考：https://forum.openwrt.org/t/archer-c7-v2-switching-off-all-leds-at-night/13730/3

controlLeds(){
  # shellcheck disable=SC2044
  for p in $(find /sys/devices/platform/leds/leds -name brightness)
  do
  echo "$1" > "$p"
  done
}

switchLeds(){
	if [ "$(date +%H)" -ge 22 ]; then
		controlLeds 0
	else
		controlLeds 1
	fi
}

switchLeds