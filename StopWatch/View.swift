//
//  View.swift
//  StopWatch
//
//  Created by ppx on 2025/2/12.
//


import UIKit
import Combine



// View
class ViewController: UIViewController {
    var playBtn: UIButton!
    var pauseBtn: UIButton!
    var timeLabel: UILabel!

    let viewModel = StopwatchViewModel()
    private var cancellables = Set<AnyCancellable>()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return.lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }

    func setupUI() {
        view.backgroundColor = .black

        timeLabel = UILabel()
        timeLabel.textColor = .white
        timeLabel.font = UIFont.systemFont(ofSize: 40)
        timeLabel.textAlignment = .center
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timeLabel)

        playBtn = UIButton(type:.system)
        playBtn.setTitle("Play", for:.normal)
        playBtn.setTitleColor(.white, for:.normal)
        playBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        playBtn.backgroundColor = .systemGreen
        playBtn.layer.cornerRadius = 8
        playBtn.translatesAutoresizingMaskIntoConstraints = false
        playBtn.addTarget(self, action: #selector(playButtonDidTouch(_:)), for:.touchUpInside)
        view.addSubview(playBtn)

        pauseBtn = UIButton(type:.system)
        pauseBtn.setTitle("Pause", for:.normal)
        pauseBtn.setTitleColor(.white, for:.normal)
        pauseBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        pauseBtn.backgroundColor = .systemRed
        pauseBtn.layer.cornerRadius = 8
        pauseBtn.translatesAutoresizingMaskIntoConstraints = false
        pauseBtn.addTarget(self, action: #selector(pauseButtonDidTouch(_:)), for:.touchUpInside)
        view.addSubview(pauseBtn)

        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),

            playBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            playBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            playBtn.widthAnchor.constraint(equalToConstant: 100),
            playBtn.heightAnchor.constraint(equalToConstant: 50),

            pauseBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            pauseBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            pauseBtn.widthAnchor.constraint(equalToConstant: 100),
            pauseBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    func bindViewModel() {
        viewModel.$counterString
           .sink { [weak self] value in
                self?.timeLabel.text = value
            }
           .store(in: &cancellables)

        viewModel.$isButtonEnabled
           .sink { [weak self] value in
                self?.playBtn.isEnabled = value
                self?.pauseBtn.isEnabled = !value
            }
           .store(in: &cancellables)
    }

    @objc func playButtonDidTouch(_ sender: UIButton) {
        viewModel.model.startTimer()
    }

    @objc func pauseButtonDidTouch(_ sender: UIButton) {
        viewModel.model.stopTimer()
    }
}
