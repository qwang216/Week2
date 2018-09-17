//
//  TimerViewModel.swift
//  Week2
//
//  Created by Jason wang on 9/14/18.
//  Copyright © 2018 JasonWang. All rights reserved.
//

import Foundation
import UIKit

class TimerViewModel {
    var timeTracker = Observable<String>("00:00")
    var speechColorState = Observable<UIColor>(.white)
    public private(set) var isRunning = Observable<Bool>(false)
    private var categories: [Category]
    var selectedCategory = Observable<Category>(Category(name: "Test Timer", min: 1, max: 2))
    private var timeCounter: Int = 0
    private var timer: Timer?

    init(categories: [Category]) {
        self.categories = categories
        self.selectedCategory.value = categories.first!
    }

    func numberOfCategories() -> Int {
        return categories.count
    }

    func categoryAt(index: Int) -> Category {
        return categories[index]
    }

    func categoryTitleFor(index: Int) -> String {
        let category = categories[index]
        return formatTitleFor(category)
    }

    func formatTitleFor(_ category: Category) -> String {
        let name = category.name
        let min = category.min
        let max = category.max
        return "\(name) - MIN:\(min) MAX:\(max)"
    }

    func setSelected(_ category: Category) {
        selectedCategory.value = category
    }
    
    func playPause() {

        if isRunning.value {
            timer?.invalidate()
            isRunning.value = false
            
        } else {
            setupTimer()
            isRunning.value = true
        }
    }

    func reset() {
        timeCounter = -1
        updateTimer()
    }

    private func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.00, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        isRunning.value = true
    }

    @objc private func updateTimer() {
        timeCounter += 1
        speechColorState.value = updateSpeechColorState(currentTime: TimeInterval(timeCounter / 60) , category: selectedCategory.value)
        timeTracker.value = converTimeCounterToString(counter: timeCounter)
    }

    private func converTimeCounterToString(counter: Int) -> String {
        let sec = counter % 60

        let min = (counter / 60) < 1 ? 0 : counter / 60
        return "\(shouldAddPrefixZero(min)):\(shouldAddPrefixZero(sec))"
    }

    private func shouldAddPrefixZero(_ time: Int) -> String {
        return time < 10 ? "0\(time)" : "\(time)"
    }

    private func updateSpeechColorState(currentTime: TimeInterval, category: Category) -> UIColor {
        var colorState: UIColor = .white

        if currentTime >= category.min && currentTime < category.mid {
            colorState =  .green
        } else if currentTime >= category.mid && currentTime < category.max {
            colorState =  .yellow
        } else if currentTime >= category.max {
            colorState = .red
        }
        
        return colorState
    }
    



}
