//
//  Models.swift
//  StopWatch
//
//  Created by ppx on 2025/2/12.
//

import Foundation

// Model
class StopwatchModel: ObservableObject {
    @Published var counter: Float = 0.0
    @Published var isPlaying: Bool = false
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

    @objc func reStart() {
        counter = 0.0
    }
}
