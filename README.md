# AutoBuild-OpenWrt

## 使用

1. 参考[coolsnowwolf/lede](https://github.com/coolsnowwolf/lede)，配置好开发环境
2. 切换到 lede 项目中，`make menuconfig`：选择你的机型，需要的驱动、软件等
3. `./scripts/diffconfig.sh > diffconfig`：根据`.config`生成差异配置
4. 复制`diffconfig`文件到当前项目 config 目录下匹配机型的 config 文件，比如：`config/linksys_ea7500v2.config`
5. GitHub action
    * 触发条件
      1. 点击 GitHub action 对应的 [workflow](https://github.com/zqhong/AutoBuild-OpenWrt/actions/workflows/Build_OP_Linksys_EA7500V2.yml)，点击【Run Workflow】按钮手动触发
      2. 创建标签/发行版
    * 文件名规则。示例：`OpenWrt_r4608-ddc2b246d_linksys_ea7500-v2_202206280713`
      * OpenWrt_version_device_date
        * 版本：REV-commit。示例：`r4608-ddc2b246d`，代表：第4628条commit，最后一条 Commit ID 为[ddc2b246d](https://github.com/coolsnowwolf/lede/commit/ddc2b246d)

## 固件信息

* 默认登陆 IP：192.168.1.1
* 密码：password

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
      * 开源/闭源驱动的设置，可以参考上面的链接俩面特定机型的设置。
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

## 自定义（customize.sh）

根据自身情况调整，默认不启用。

### 修改默认 IP 为 192.168.5.1

```bash
sed -i 's/192.168.1.1/192.168.5.1/g' openwrt/package/base-files/files/bin/config_generate
```

相关文件：https://github.com/coolsnowwolf/lede/blob/master/package/base-files/files/bin/config_generate

### 设置空密码（默认密码为 password）

```bash
sed -i 's/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.//g' openwrt/package/lean/default-settings/files/zzz-default-settings
```

相关文件：https://github.com/coolsnowwolf/lede/blob/master/package/lean/default-settings/files/zzz-default-settings

## 参考

* 编译
    * [Quick image building guide - OpenWrt Wiki](https://openwrt.org/docs/guide-developer/toolchain/beginners-build-guide)
    * [OpenWrt 编译 LuCI -> Applications 添加插件应用说明-L大【2021.11.18】](https://www.right.com.cn/forum/thread-344825-1-1.html)
* 设备
    * Linksys EA7500 V2
        * https://github.com/sherlsenlinmu/Actions-OpenWrt/blob/main/.github/workflows/EA7500V2.yml
        * https://github.com/althea-net/althea-firmware/blob/master/config/ea7500v2
        * https://downloads.openwrt.org/releases/21.02.3/targets/ramips/mt7621/config.buildinfo
        * https://openwrt.org/toh/linksys/linksys_ea7500_v2
* 开源驱动与闭源驱动
  * mt7615
    * [【20220502更新】领势EA7500V2开源与闭源驱动openwrt固件](https://www.right.com.cn/forum/thread-4103473-1-1.html)
    * [mt7615 还有必要使用闭源版本驱动吗？](https://github.com/coolsnowwolf/lede/issues/6102)
    * [How to use mt driver instead of mt76?](https://github.com/coolsnowwolf/lede/issues/5897)
* OpenWrt GitHub action 相关
    * https://github.com/coolsnowwolf/lede/blob/master/.github/workflows/openwrt-ci.yml
    * https://github.com/esirplayground/AutoBuild-OpenWrt/blob/master/.github/workflows/Build_OP_Redmi_AC2100.yml
    * https://github.com/P3TERX/Actions-OpenWrt/blob/main/.github/workflows/build-openwrt.yml
