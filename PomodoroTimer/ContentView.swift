import SwiftUI
import Foundation
import AVFoundation

// MARK: - Timer State Enum
enum TimerState {
    case work
    case shortBreak
    case longBreak
    case stopped
}

// MARK: - Pomodoro Timer Model
class PomodoroTimerModel: ObservableObject {
    @Published var timeRemaining: TimeInterval = 25 * 60 // 25 minutes in seconds
    @Published var isRunning = false
    @Published var currentState: TimerState = .work
    @Published var completedPomodoros = 0
    
    private var timer: Timer?
    private var audioPlayer: AVAudioPlayer?
    
    // Timer durations (in seconds)
    let workDuration: TimeInterval = 25 * 60 // 25 minutes
    let shortBreakDuration: TimeInterval = 5 * 60 // 5 minutes
    let longBreakDuration: TimeInterval = 15 * 60 // 15 minutes
    
    init() {
        setupAudioPlayer()
    }
    
    private func setupAudioPlayer() {
        // Create a simple beep sound programmatically
        guard let url = Bundle.main.url(forResource: "notification", withExtension: "wav") else {
            // If no sound file exists, we'll use system sound
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
        } catch {
            print("Failed to setup audio player: \(error)")
        }
    }
    
    func startTimer() {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.updateTimer()
        }
    }
    
    func pauseTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }
    
    func resetTimer() {
        pauseTimer()
        switch currentState {
        case .work:
            timeRemaining = workDuration
        case .shortBreak:
            timeRemaining = shortBreakDuration
        case .longBreak:
            timeRemaining = longBreakDuration
        case .stopped:
            timeRemaining = workDuration
            currentState = .work
        }
    }
    
    private func updateTimer() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            // Timer finished
            timerCompleted()
        }
    }
    
    private func timerCompleted() {
        pauseTimer()
        playNotificationSound()
        
        switch currentState {
        case .work:
            completedPomodoros += 1
            // After 4 pomodoros, take a long break
            if completedPomodoros % 4 == 0 {
                currentState = .longBreak
                timeRemaining = longBreakDuration
            } else {
                currentState = .shortBreak
                timeRemaining = shortBreakDuration
            }
        case .shortBreak, .longBreak:
            currentState = .work
            timeRemaining = workDuration
        case .stopped:
            break
        }
    }
    
    private func playNotificationSound() {
        // Play system sound if no custom sound is available
        AudioServicesPlaySystemSound(1005) // System notification sound
        
        // Or play custom sound if available
        audioPlayer?.play()
    }
    
    func skipToBreak() {
        pauseTimer()
        if currentState == .work {
            completedPomodoros += 1
            currentState = completedPomodoros % 4 == 0 ? .longBreak : .shortBreak
            timeRemaining = currentState == .longBreak ? longBreakDuration : shortBreakDuration
        }
    }
    
    func skipToWork() {
        pauseTimer()
        currentState = .work
        timeRemaining = workDuration
    }
}

// MARK: - Main Pomodoro Timer View
struct ContentView: View {
    @StateObject private var timerModel = PomodoroTimerModel()
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                if geometry.size.width > geometry.size.height {
                    // 橫屏布局
                    landscapeLayout
                } else {
                    // 直屏布局
                    portraitLayout
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
    // 直屏布局
    private var portraitLayout: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header with current state
                headerView
                
                // Circular Progress Timer
                timerCircleView(size: min(250, UIScreen.main.bounds.width * 0.6))
                
                // Control buttons
                controlButtonsView
                
                // Skip buttons
                skipButtonView
                
                // Statistics
                statisticsView
            }
            .padding()
        }
        .navigationTitle("番茄鐘")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // 橫屏布局
    private var landscapeLayout: some View {
        ScrollView {
            HStack(spacing: 30) {
                // 左側：計時器和標題
                VStack(spacing: 15) {
                    headerView
                    timerCircleView(size: min(200, UIScreen.main.bounds.height * 0.5))
                }
                .frame(maxWidth: .infinity)
                
                // 右側：控制按鈕和統計
                VStack(spacing: 20) {
                    controlButtonsView
                    skipButtonView
                    statisticsView
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
        }
        .navigationTitle("番茄鐘")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // 標題區域
    private var headerView: some View {
        VStack(spacing: 8) {
            Text(stateTitle)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(stateColor)
                .multilineTextAlignment(.center)
            
            Text("番茄鐘 #\(timerModel.completedPomodoros + 1)")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    // 計時器圓圈
    private func timerCircleView(size: CGFloat) -> some View {
        ZStack {
            // Background circle
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 8)
                .frame(width: size, height: size)
            
            // Progress circle
            Circle()
                .trim(from: 0, to: progress)
                .stroke(stateColor, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .frame(width: size, height: size)
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 1), value: progress)
            
            // Time display
            VStack(spacing: 5) {
                Text(timeString)
                    .font(.system(size: min(48, size * 0.2), weight: .bold, design: .monospaced))
                    .foregroundColor(stateColor)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                
                Text(stateDescription)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .padding()
        }
    }
    
    // 控制按鈕
    private var controlButtonsView: some View {
        HStack(spacing: 20) {
            // Start/Pause button
            Button(action: {
                if timerModel.isRunning {
                    timerModel.pauseTimer()
                } else {
                    timerModel.startTimer()
                }
            }) {
                Image(systemName: timerModel.isRunning ? "pause.fill" : "play.fill")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .background(stateColor)
                    .clipShape(Circle())
            }
            
            // Reset button
            Button(action: {
                timerModel.resetTimer()
            }) {
                Image(systemName: "arrow.clockwise")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .background(Color.gray)
                    .clipShape(Circle())
            }
        }
    }
    
    // 跳過按鈕
    private var skipButtonView: some View {
        HStack(spacing: 15) {
            if timerModel.currentState == .work {
                Button("跳過到休息") {
                    timerModel.skipToBreak()
                }
                .buttonStyle(SecondaryButtonStyle())
            } else {
                Button("跳過到工作") {
                    timerModel.skipToWork()
                }
                .buttonStyle(SecondaryButtonStyle())
            }
        }
    }
    
    // 統計區域
    private var statisticsView: some View {
        VStack(spacing: 8) {
            Text("今日完成")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Text("\(timerModel.completedPomodoros)")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(stateColor)
            
            Text("個番茄鐘")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    // MARK: - Computed Properties
    private var stateTitle: String {
        switch timerModel.currentState {
        case .work:
            return "專注工作時間"
        case .shortBreak:
            return "短休息時間"
        case .longBreak:
            return "長休息時間"
        case .stopped:
            return "準備開始"
        }
    }
    
    private var stateDescription: String {
        switch timerModel.currentState {
        case .work:
            return "保持專注，努力工作！"
        case .shortBreak:
            return "稍作休息，放鬆一下"
        case .longBreak:
            return "好好休息，恢復精力"
        case .stopped:
            return "點擊開始按鈕"
        }
    }
    
    private var stateColor: Color {
        switch timerModel.currentState {
        case .work:
            return .red
        case .shortBreak:
            return .green
        case .longBreak:
            return .blue
        case .stopped:
            return .gray
        }
    }
    
    private var timeString: String {
        let minutes = Int(timerModel.timeRemaining) / 60
        let seconds = Int(timerModel.timeRemaining) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private var progress: Double {
        let totalDuration: TimeInterval
        switch timerModel.currentState {
        case .work:
            totalDuration = timerModel.workDuration
        case .shortBreak:
            totalDuration = timerModel.shortBreakDuration
        case .longBreak:
            totalDuration = timerModel.longBreakDuration
        case .stopped:
            totalDuration = timerModel.workDuration
        }
        
        return 1.0 - (timerModel.timeRemaining / totalDuration)
    }
}

// MARK: - Custom Button Style
struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(Color.gray.opacity(0.2))
            .foregroundColor(.primary)
            .cornerRadius(20)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}


// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}