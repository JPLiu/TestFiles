# Aria2AHK

用 AutoHotkey 写的 Aria2 启动托盘，托盘支持菜单添加任务和 Torrent，可配合 Aria2 的浏览器的扩展使用。

## 版本历史

### 2025.10.18

- 更新至 AutoHotkey 2.0.19。
- 增加“清理下载路径”功能，用于清理下载文件夹下未完成下载的文件，可能会有误删。

### 2024.12.03

- 更新至 AutoHotkey 2.0.18。

### 2023.11.26

- 更新至 AutoHotkey 2.0.10。
- Aria2Task.exe 更新，托盘菜单添加任务支持同时添加多个任务。

### 2023.11.16

- 脚本优化。

### 2023.07.23

- 移除下载速度上限切换菜单，修改为根据 Aria2AHK 启动时连接的热点的 SSID 名称自动设置限速，
- 增加 **SpeedLimitSSID1**、**SpeedLimitSSID2**、**SpeedLimitSSID3** 用于配置不同限速的 SSID 名称（以`,`分隔），
- **SelectSpeedLimit** 配置项修改为当前连接热点未指定限速时使用的限速。

### 2023.05.26

- 增加下载速度上限的配置项和切换菜单，用来应付不同场景（如家里的 1000 兆独占宽带和宿舍的 300 兆合租宽带）。

### 2023.02.12

- 更新至 AutoHotkey v2，
- 增加 Aria2Task.exe 用于链接调用和添加任务，
- 增加 Aria2Torrent.exe 用于 Torrent 文件关联（Base64 解密用 certutil.exe 实现），
- 增加 Aria2TorrentClean.reg 用于清理 Torrent 文件的文件关联。

### 2022.08.15

- 基于 AutoHotkey v1.1 编写。

