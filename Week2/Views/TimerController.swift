//
//  ViewController.swift
//  Week2
//
//  Created by Jason wang on 9/10/18.
//  Copyright © 2018 JasonWang. All rights reserved.
//

import UIKit

class TimerController: UIViewController {
    static let storybaordID = "timerControllerStoryboardID"

    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var loaderContainerView: UIView!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    @IBOutlet weak var pickerContainerView: UIView!
    lazy var loaderView = CircularLoader(frame: loaderContainerView.bounds)

    var timerViewModel: TimerViewModel?



    let timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()

        loaderContainerView.addSubview(loaderView)
        setupButtonTarget()
        bindViewModelProperties()
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
        categoryPickerView.isHidden = true
        pickerContainerView.isHidden = true

    }

    func bindViewModelProperties() {

        timerViewModel?.timeTracker.bind { [unowned self] in
            self.loaderView.timeStampLabel.text = "\($0)"
        }
        timerViewModel?.isRunning.bind { [unowned self] in
            self.resetButton.isEnabled = !$0
            self.playPauseButton.setImage($0 ? #imageLiteral(resourceName: "pause") : #imageLiteral(resourceName: "play"), for: .normal)
        }
        timerViewModel?.speechColorState.bind { [unowned self] in
            self.view.backgroundColor = $0
        }

        timerViewModel?.selectedCategory.bind { [unowned self] in
            self.categoryButton.setTitle(self.timerViewModel?.formatTitleFor($0), for: .normal)
        }

        timerViewModel?.percentCompletion.bind { [unowned self] in
            self.loaderView.startAnimate(with: $0)
        }

    }

    func setupButtonTarget() {
        playPauseButton.addTarget(self, action: #selector(playPauseButtonHandler), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetButtonHandler), for: .touchUpInside)
        categoryButton.addTarget(self, action: #selector(categoryButtonHandler), for: .touchUpInside)
    }

    @objc func playPauseButtonHandler(button: UIButton) {
        timerViewModel?.playPause()
    }

    @objc func resetButtonHandler(button: UIButton) {
        timerViewModel?.reset()
    }

    @objc func categoryButtonHandler() {
        categoryPickerView.isHidden = categoryPickerView.isHidden ? false : true
        pickerContainerView.isHidden = pickerContainerView.isHidden ? false : true

    }

}

extension TimerController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let viewModel = timerViewModel else { return }
        viewModel.setSelected(viewModel.categoryAt(index: row))
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return timerViewModel?.categoryTitleFor(index: row)
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timerViewModel?.numberOfCategories() ?? 0
    }


}

