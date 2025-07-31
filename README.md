# 🍅 番茄鐘 SwiftUI App

一個功能完整的番茄鐘應用，使用SwiftUI開發，支持iOS 15.0+。

## 功能特色

- ⏰ **經典番茄鐘時間設定**
  - 25分鐘工作時間
  - 5分鐘短休息
  - 15分鐘長休息（每4個番茄鐘後）

- 🎨 **美觀的用戶界面**
  - 圓形進度指示器
  - 大字體倒計時顯示
  - 不同狀態的顏色主題（工作=紅色，短休息=綠色，長休息=藍色）

- 🎮 **完整的控制功能**
  - 開始/暫停按鈕
  - 重置按鈕
  - 跳過功能（可以跳過當前階段）

- 📊 **統計功能**
  - 顯示今日完成的番茄鐘數量
  - 自動追蹤進度

- 🔊 **聲音提醒**
  - 每個階段結束時播放系統提示音

- 🇹🇼 **中文界面**
  - 完全中文化的用戶界面

## 如何運行

### 方法1：使用Xcode
1. 下載或克隆此項目
2. 雙擊 `PomodoroTimer.xcodeproj` 文件
3. 在Xcode中選擇目標設備（iPhone模擬器或真機）
4. 點擊運行按鈕（▶️）

### 方法2：使用Xcode命令行
```bash
# 在項目根目錄執行
xcodebuild -project PomodoroTimer.xcodeproj -scheme PomodoroTimer -destination 'platform=iOS Simulator,name=iPhone 15' build
```

## 項目結構

```
PomodoroTimer/
├── PomodoroTimer.xcodeproj/     # Xcode項目文件
├── PomodoroTimer/               # 主要源代碼目錄
│   ├── PomodoroTimerApp.swift   # App入口點
│   ├── ContentView.swift        # 主要UI和邏輯
│   ├── Assets.xcassets/         # 應用資源
│   └── Preview Content/         # 預覽資源
├── Package.swift                # Swift Package Manager配置
└── README.md                    # 項目說明文件
```

## 系統要求

- iOS 15.0+
- Xcode 14.0+
- Swift 5.7+

## 使用說明

1. **開始工作**：點擊播放按鈕開始25分鐘的工作時間
2. **暫停/繼續**：點擊暫停按鈕可以暫停計時器，再次點擊繼續
3. **重置**：點擊重置按鈕重新開始當前階段
4. **跳過**：使用跳過按鈕可以提前結束當前階段
5. **自動切換**：工作時間結束後自動切換到休息時間，反之亦然

## 番茄鐘工作法

番茄鐘工作法是一種時間管理技術：

1. 選擇一個要完成的任務
2. 設定番茄鐘為25分鐘
3. 專注工作直到番茄鐘響起
4. 短暫休息5分鐘
5. 每4個番茄鐘後，休息15-30分鐘

## 自定義

你可以在 `PomodoroTimerModel` 類中修改以下設定：

```swift
let workDuration: TimeInterval = 25 * 60 // 工作時間（秒）
let shortBreakDuration: TimeInterval = 5 * 60 // 短休息時間（秒）
let longBreakDuration: TimeInterval = 15 * 60 // 長休息時間（秒）
```

## 許可證

此項目僅供學習和個人使用。

## 貢獻

歡迎提交問題和改進建議！