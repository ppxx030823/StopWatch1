//
//  Models.swift
//  StopWatch
//
//  Created by ppx on 2025/2/12.
//

import Foundation

// Model
class StopwatchModel {
    var counter: Float = 0.0 {
        didSet {
            // 在这里可以添加一些数据变化的逻辑，比如保存到持久化存储
        }
    }
    var isPlaying: Bool = false
    var timer: Timer?

    func startTimer() {
        isPlaying = true
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }

    func stopTimer() {
        isPlaying = false
        timer?.invalidate()
        timer = nil
    }

    func resetTimer() {
        stopTimer()
        counter = 0.0
    }

    @objc func updateCounter() {
        counter += 0.1
    }
}
