//
//  View.swift
//  StopWatch
//
//  Created by ppx on 2025/2/12.
//


import UIKit
import Combine
import SnapKit



// View
class ViewController: UIViewController {
    var playBtn: UIButton! = {
        let playBtn = UIButton(type:.system)
        playBtn.setTitle("Play", for:.normal)
        playBtn.setTitleColor(.white, for:.normal)
        playBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        playBtn.backgroundColor = .systemGreen
        playBtn.layer.cornerRadius = 8
        playBtn.translatesAutoresizingMaskIntoConstraints = false
        playBtn.addTarget(self, action: #selector(playButtonDidTouch(_:)), for:.touchUpInside)
        return playBtn
    }()

    var pauseBtn: UIButton! = {
        let pauseBtn = UIButton(type:.system)
        pauseBtn.setTitle("Pause", for:.normal)
        pauseBtn.setTitleColor(.white, for:.normal)
        pauseBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        pauseBtn.backgroundColor = .systemRed
        pauseBtn.layer.cornerRadius = 8
        pauseBtn.translatesAutoresizingMaskIntoConstraints = false
        pauseBtn.addTarget(self, action: #selector(pauseButtonDidTouch(_:)), for:.touchUpInside)
        return pauseBtn
    }()

    var timeLabel: UILabel! = {
        let timeLabel = UILabel()
        timeLabel.textColor = .white
        timeLabel.font = UIFont.systemFont(ofSize: 40)
        timeLabel.textAlignment = .center
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeLabel
    }()

    let viewModel = StopwatchViewModel()
    private var cancellables = Set<AnyCancellable>()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return.lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addupUI()
        setUpUI()
        bindViewModel()
    }

    func addupUI() {
        view.backgroundColor = .black
        view.addSubview(timeLabel)
        view.addSubview(playBtn)
        view.addSubview(pauseBtn)

    }

    func setUpUI() {
        timeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview() // 水平居中
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100) // 距离安全区域顶部 100
        }

        playBtn.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(50) // 距离左边 50
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50) // 距离安全区域底部 50
            make.width.equalTo(100) // 宽度 100
            make.height.equalTo(50) // 高度 50
        }

        pauseBtn.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-50) // 距离右边 50
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50) // 距离安全区域底部 50
            make.width.equalTo(100) // 宽度 100
            make.height.equalTo(50) // 高度 50
        }
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
