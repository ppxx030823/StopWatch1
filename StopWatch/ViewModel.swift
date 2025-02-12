//
//  ViewController.swift
//  StopWatch
//
//  Created by ppx on 2025/2/12.
//

import UIKit
import Combine


// ViewModel
class StopwatchViewModel: ObservableObject {
    @Published var counterString: String = "0.0"
    @Published var isButtonEnabled: Bool = true
    private var cancellables = Set<AnyCancellable>()
    let model = StopwatchModel()

    init() {
        model.$counter
           .map { String(format: "%.1f", $0) }
           .assign(to: \.counterString, on: self)
           .store(in: &cancellables)

        model.$isPlaying
           .map {!$0 }
           .assign(to: \.isButtonEnabled, on: self)
           .store(in: &cancellables)
    }
}
