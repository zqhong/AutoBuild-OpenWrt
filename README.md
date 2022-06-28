# AutoBuild-OpenWrt

## 使用

1. 参考[coolsnowwolf/lede](https://github.com/coolsnowwolf/lede)的项目说明，配置好编译环境，生成`.config`文件
2. 参考[esirplayground/AutoBuild-OpenWrt](https://github.com/esirplayground/AutoBuild-OpenWrt)的项目说明，配置好 GitHub action，即`.github/workflows/*.yml`文件。

## 设备

### Linksys EA7500 V2

#### 硬件信息

* Soc：MediaTek MT7621AT，880 MHz
* Flash：128 MB NAND
* RAM：256 MB
* WLAN Hardware：MediaTek MT7615N
* WLAN2.4：b/g/n
* WLAN5.0：a/n/ac
* 100M port：0
* Gbit ports：5

#### 开源和闭源驱动

* 开源（kmod-mt7615e、kmod-mt7615-firmware）
  * 优点：支持 WPA3、MESH、802.11K/V/R（无缝漫游）
  * 使用：取消闭源驱动，选择 kmod-mt7615-firmware 和 kmod-mt7615e
* 闭源（kmod-mt7615d）
    * 优点：支持 HWNAT、信号好（论坛反馈，未测试）
    * 使用：取消开源驱动，选择 kmod-mt7615d 和 luci-app-mtwifi
    * 备注
      * 闭源驱动刷机及重置后第一次 WiFi 不能自动启动，需自备网线连接手动重启
* 其他
  * kmod-mt7615d_dbdc：只适用于 mt7615dn
  * luci-app-mtwifi：LuCI support for mt wifi driver。（为闭源驱动提供设置界面）
  * EA7500 V2 默认使用开源驱动，参考：https://github.com/coolsnowwolf/lede/blob/master/target/linux/ramips/image/mt7621.mk#L932-L938
      * 不知道怎么选择闭源驱动的时候，可以参考上面的链接，参考特定机型的设置。
      * 默认编译结果（开源驱动）
        * kmod-mt76-connac - 5.4.199+2022-06-24-b6e865e2-4
        * kmod-mt76-core - 5.4.199+2022-06-24-b6e865e2-4
        * kmod-mt7615-common - 5.4.199+2022-06-24-b6e865e2-4
        * kmod-mt7615-firmware - 5.4.199+2022-06-24-b6e865e2-4
        * kmod-mt7615e - 5.4.199+2022-06-24-b6e865e2-4
      * 闭源驱动编译结果
        * kmod-mt7615d - 5.4.115+5.0.4.0-1
        * luci-app-mtwifi - 1-16
        * mt_wifi - 1-1

#### 参考

* [【20220502更新】领势EA7500V2开源与闭源驱动openwrt固件](https://www.right.com.cn/forum/thread-4103473-1-1.html)
* [mt7615 还有必要使用闭源版本驱动吗？](https://github.com/coolsnowwolf/lede/issues/6102)
* [How to use mt driver instead of mt76?](https://github.com/coolsnowwolf/lede/issues/5897)
* https://github.com/sherlsenlinmu/Actions-OpenWrt/blob/main/.github/workflows/EA7500V2.yml
* https://github.com/althea-net/althea-firmware/blob/master/config/ea7500v2
* https://downloads.openwrt.org/releases/21.02.3/targets/ramips/mt7621/config.buildinfo
* https://openwrt.org/toh/linksys/linksys_ea7500_v2


## 编译

* [OpenWrt 编译 LuCI -> Applications 添加插件应用说明-L大【2021.11.18】](https://www.right.com.cn/forum/thread-344825-1-1.html)
