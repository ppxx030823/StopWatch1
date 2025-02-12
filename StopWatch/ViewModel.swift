//
//  ViewController.swift
//  StopWatch
//
//  Created by ppx on 2025/2/12.
//

import UIKit


// ViewModel
class StopwatchViewModel {
    let model = StopwatchModel()
    var counterString: String {
        return String(format: "%.1f", model.counter)
    }
    var isButtonEnabled: Bool {
        return !model.isPlaying
    }
}
