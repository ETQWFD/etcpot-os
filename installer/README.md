# EtcPot OS — 一键安装程序

| 平台 | 脚本 | 前置条件 |
|---|---|---|
| Linux / macOS | `install.sh` | `adb` / `fastboot`（android-platform-tools） |
| Windows | `install.bat` | 同上 + 手机 USB 驱动 |

## 使用步骤

1. 手机进入 **fastboot 模式**：关机后按住 `音量下 + 电源键`。
2. USB 连接电脑，确认 `fastboot devices` 能看到设备序列号。
3. 运行：
   ```bash
   bash install.sh /path/to/etcpot-1.0-image.zip
   ```
4. 等待自动刷写完成，设备自动重启。首次开机 2-3 分钟。

## 安全提示

- 刷机会**清除全部用户数据**。
- 解锁 bootloader 会触发 Knox / SafetyNet 熔断，部分银行/支付应用可能不可用。
- 仅建议在**开发者设备 / 备用机**上测试。
