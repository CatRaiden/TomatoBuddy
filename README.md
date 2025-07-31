# 🍅 TomatoBuddy - Pomodoro Timer SwiftUI App

A fully-featured Pomodoro Timer application built with SwiftUI, supporting iOS 15.0+.  
一個功能完整的番茄鐘應用，使用SwiftUI開發，支持iOS 15.0+。

## Features | 功能特色

- ⏰ **Classic Pomodoro Timer Settings | 經典番茄鐘時間設定**
  - 25-minute work sessions | 25分鐘工作時間
  - 5-minute short breaks | 5分鐘短休息
  - 15-minute long breaks (after every 4 pomodoros) | 15分鐘長休息（每4個番茄鐘後）

- 🎨 **Beautiful User Interface | 美觀的用戶界面**
  - Circular progress indicator | 圓形進度指示器
  - Large countdown display | 大字體倒計時顯示
  - Color themes for different states (Work=Red, Short Break=Green, Long Break=Blue) | 不同狀態的顏色主題（工作=紅色，短休息=綠色，長休息=藍色）

- 🎮 **Complete Control Features | 完整的控制功能**
  - Start/Pause button | 開始/暫停按鈕
  - Reset button | 重置按鈕
  - Skip functionality | 跳過功能（可以跳過當前階段）

- 📊 **Statistics | 統計功能**
  - Display today's completed pomodoros | 顯示今日完成的番茄鐘數量
  - Automatic progress tracking | 自動追蹤進度

- 🔊 **Sound Notifications | 聲音提醒**
  - System sound alerts at the end of each phase | 每個階段結束時播放系統提示音

- 🇹🇼 **Chinese Interface | 中文界面**
  - Fully localized Chinese user interface | 完全中文化的用戶界面

## How to Run | 如何運行

### Method 1: Using Xcode | 方法1：使用Xcode
1. Download or clone this project | 下載或克隆此項目
2. Double-click the `PomodoroTimer.xcodeproj` file | 雙擊 `PomodoroTimer.xcodeproj` 文件
3. Select target device in Xcode (iPhone Simulator or real device) | 在Xcode中選擇目標設備（iPhone模擬器或真機）
4. Click the Run button (▶️) | 點擊運行按鈕（▶️）

### Method 2: Using Xcode Command Line | 方法2：使用Xcode命令行
```bash
# Execute in project root directory | 在項目根目錄執行
xcodebuild -project PomodoroTimer.xcodeproj -scheme PomodoroTimer -destination 'platform=iOS Simulator,name=iPhone 15' build
```

## Project Structure | 項目結構

```
PomodoroTimer/
├── PomodoroTimer.xcodeproj/     # Xcode project file | Xcode項目文件
├── PomodoroTimer/               # Main source code directory | 主要源代碼目錄
│   ├── PomodoroTimerApp.swift   # App entry point | App入口點
│   ├── ContentView.swift        # Main UI and logic | 主要UI和邏輯
│   ├── Assets.xcassets/         # App resources | 應用資源
│   └── Preview Content/         # Preview resources | 預覽資源
├── Package.swift                # Swift Package Manager config | Swift Package Manager配置
└── README.md                    # Project documentation | 項目說明文件
```

## System Requirements | 系統要求

- iOS 15.0+
- Xcode 14.0+
- Swift 5.7+

## Usage Instructions | 使用說明

1. **Start Working | 開始工作**: Click the play button to start a 25-minute work session | 點擊播放按鈕開始25分鐘的工作時間
2. **Pause/Resume | 暫停/繼續**: Click the pause button to pause the timer, click again to resume | 點擊暫停按鈕可以暫停計時器，再次點擊繼續
3. **Reset | 重置**: Click the reset button to restart the current phase | 點擊重置按鈕重新開始當前階段
4. **Skip | 跳過**: Use the skip button to end the current phase early | 使用跳過按鈕可以提前結束當前階段
5. **Auto Switch | 自動切換**: Automatically switches to break time after work time ends, and vice versa | 工作時間結束後自動切換到休息時間，反之亦然

## The Pomodoro Technique | 番茄鐘工作法

The Pomodoro Technique is a time management method: | 番茄鐘工作法是一種時間管理技術：

1. Choose a task to be accomplished | 選擇一個要完成的任務
2. Set the Pomodoro timer to 25 minutes | 設定番茄鐘為25分鐘
3. Work on the task until the timer rings | 專注工作直到番茄鐘響起
4. Take a short 5-minute break | 短暫休息5分鐘
5. After every 4 Pomodoros, take a longer 15-30 minute break | 每4個番茄鐘後，休息15-30分鐘

## Customization | 自定義

You can modify the following settings in the `PomodoroTimerModel` class: | 你可以在 `PomodoroTimerModel` 類中修改以下設定：

```swift
let workDuration: TimeInterval = 25 * 60 // Work time (seconds) | 工作時間（秒）
let shortBreakDuration: TimeInterval = 5 * 60 // Short break time (seconds) | 短休息時間（秒）
let longBreakDuration: TimeInterval = 15 * 60 // Long break time (seconds) | 長休息時間（秒）
```

## License | 許可證

This project is for learning and personal use only. | 此項目僅供學習和個人使用。

## Contributing | 貢獻

Issues and improvement suggestions are welcome! | 歡迎提交問題和改進建議！