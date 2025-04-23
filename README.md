# WorkoutTimer – 筋トレタイマーアプリ

## 概要
ポートフォリオ用に1日〜2日でSwiftUIで実装した筋トレタイマーアプリです。  
運動時間・休憩時間・セット数を指定してタイマー実行が可能です。

## 使用技術
- SwiftUI（UI）
- MVVM（アーキテクチャ）
- Combine（タイマー制御）
- XCTest（ユニットテスト）

## 機能一覧
- 運動時間・休憩時間・セット数の設定
- 状態管理と画面遷移（運動 → 休憩 → 完了）
- タイマー（一時停止／リセット機能）

## 設計資料
- [要件定義](docs/requirements.md)


## スクリーンショット
| 設定画面 | タイマー画面 | 完了画面 |
|--------|--------------|----------|
| ![]() | ![]() | ![]() |

## ディレクトリ構成
workout-timer/
├── WorkoutTimerApp.swift         # アプリエントリーポイント
├── Resources/                    # 画像やカラーファイルなどのリソース
│   └── Assets.xcassets           # アセットカタログ（アイコン・カラー等）
│
├── Models/                       # データモデル定義
│   └── WorkoutSession.swift
│   └── Phase.swift
│
├── ViewModels/                   # 状態管理
│   └── WorkoutTimerViewModel.swift
│
├── Views/                        # SwiftUIの画面
│   └── SetupView.swift
│   └── TimerView.swift
│   └── CompletedView.swift
│
├── Extensions/                   # カスタムViewModifierやユーティリティ拡張
│   └── TimeFormatter.swift
│
├── Tests/                        # 単体テストファイル
│   └── WorkoutTimerTests.swift
│
├── docs/                         # ドキュメント類
│   └── requirements.md
│
├── README.md                     # プロジェクト概要と使い方            
└── .gitignore  # Git管理から除外するファイル定義


## ビルド方法
1. Xcode 15以降を使用
2. `WorkoutTimer.xcodeproj` を開いてビルド

## テスト
- `Command + U`でユニットテスト実行
- `WorkoutTimerViewModelTests.swift` にて状態遷移のテスト済み
