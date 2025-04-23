import Foundation

class WorkoutTimerViewModel: ObservableObject {
    @Published var session: WorkoutSession
    @Published var isRunning: Bool = false
    
    private var timer: Timer?
    
    init() {
        self.session = WorkoutSession(phase: .preparation, duration: 30, remainingTime: 0)
    }
    
    //タイマーを開始
    func start() {
        if isRunning { return }
        
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.session.remainingTime > 0 {
                self.session.remainingTime -= 1
            } else {
                self.pause()
            }
        }
    }

    // タイマーを一時停止
    func pause() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }

    // タイマーをリセット
    func reset() {
        session.remainingTime = session.duration
        pause()
    }
}
