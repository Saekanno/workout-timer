import Foundation

struct WorkoutSession {
    var phase: Phase       // 現在のフェーズ
    var duration: Int      // セッションの合計時間（秒）
    var remainingTime: Int // 残り時間（秒）

    mutating func updatePhase() {
        switch phase {
        case .preparation:
            phase = .workout
        case .workout:
            phase = .rest
        case .rest:
            phase = .preparation
        }
    }
}
