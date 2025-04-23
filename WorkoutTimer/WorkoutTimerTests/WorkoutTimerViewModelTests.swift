import XCTest
@testable import WorkoutTimer

final class WorkoutTimerViewModelTests: XCTestCase {

    var viewModel: WorkoutTimerViewModel!

    override func setUpWithError() throws {
        // 各テストメソッドの前に新しいViewModelを初期化
        viewModel = WorkoutTimerViewModel()
    }

    override func tearDownWithError() throws {
        // 各テストメソッドの後にリソースを解放
        viewModel = nil
    }

    // タイマーがスタートするか
    func testStartMethod() throws {
        viewModel.start()
        XCTAssertTrue(viewModel.isRunning, "タイマーが開始されるべき")
    }

    // タイマーが一時停止するか
    func testPauseMethod() throws {
        viewModel.start()  // タイマー開始
        viewModel.pause()  // 一時停止
        XCTAssertFalse(viewModel.isRunning, "タイマーは一時停止されるべき")
    }

    // タイマーがリセットされるか
    func testResetMethod() throws {
        viewModel.start()  // タイマー開始
        viewModel.reset()  // リセット
        XCTAssertEqual(viewModel.session.remainingTime, viewModel.session.duration, "リセット後、残り時間が元の値に戻るべき")
        XCTAssertFalse(viewModel.isRunning, "リセット後、タイマーは停止しているべき")
    }

    // 残り時間が減少するか
    func testRemainingTimeDecreases() throws {
        let initialTime = viewModel.session.remainingTime
        viewModel.start()
        // タイマーが1秒後に減少しているかを確認
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertLessThan(self.viewModel.session.remainingTime, initialTime, "タイマーの残り時間が減少するべき")
        }
    }

    // タイマーがゼロになったときに自動で一時停止するか
    func testTimerStopsAtZero() throws {
        viewModel.session.remainingTime = 1  // 残り時間を1秒に設定
        viewModel.start()
        // 1秒後にタイマーが停止することを確認
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(self.viewModel.isRunning, "タイマーがゼロになったとき、自動的に一時停止するべき")
        }
    }

    // タイマーが一時停止中に再度スタートして時間が減少するか
    func testStartWhilePaused() throws {
        viewModel.start()  // スタート
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.viewModel.pause()  // 1秒後に一時停止
            let pausedTime = self.viewModel.session.remainingTime

            // 1秒後に再度スタート
            self.viewModel.start()

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                XCTAssertLessThan(self.viewModel.session.remainingTime, pausedTime, "タイマーが一時停止中に再度スタートを押すと、タイマーが再度動き出して時間が減少すべき")
            }
        }
    }

    // タイマーが一時停止中に残り時間が保持されるか
    func testRemainingTimeWhenPaused() throws {
        viewModel.start()  // スタート
        let initialTime = viewModel.session.remainingTime
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.viewModel.pause()  // 1秒後に一時停止
            XCTAssertEqual(self.viewModel.session.remainingTime, initialTime - 1, "一時停止後、残り時間は進んでいるべき")
        }
    }
}
