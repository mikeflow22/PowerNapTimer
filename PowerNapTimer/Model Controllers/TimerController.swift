//
//  TimerController.swift
//  PowerNapTimer
//
//  Created by Michael Flowers on 9/24/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

protocol TimerDelegate: class {
    func timerSecondTick()
    func timerCompleted()
    func timerStopped()
}

class TimerController {
    //source of truth
    var timer: Timer?
    var timeRemaining: TimeInterval?
    weak var delegate: TimerDelegate?
    
    var isOn: Bool {
        return timeRemaining != nil ? true : false
    }
    
    func secondTicking(){
        //want to see how much time is remaining
        guard let timeLeft = timeRemaining else { return }
        if timeLeft > 0 {
            self.timeRemaining = timeLeft - 1
            //Alert the delegate to do some stuff in this function.
            delegate?.timerSecondTick()
        } else {
            // stop the timer
            timer?.invalidate()
            //set time remaining to nil
            self.timeRemaining = nil
            //Alert the delegate to do some stuff in this function
            delegate?.timerCompleted()
        }
    }
    
    func startTimer(_ time: TimeInterval) {
        if isOn == false {
            timeRemaining = time
            DispatchQueue.main.async {
                self.secondTicking()
                self.timer =  Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (_) in
                    self.secondTicking()
                })
            }
        }
    }
    
    func stopTimer(){
        if isOn == true {
            timeRemaining = nil
            timer?.invalidate()
            delegate?.timerStopped()
        }
    }
    
    func timeAsString() -> String {
        let timeLeft = Int(self.timeRemaining ?? 20 * 60) //20 mins
        let minutesLeft = timeLeft / 60
        let secondsLeft = timeLeft - (minutesLeft * 60)
        return String(format: "%02d : %02d", arguments: [minutesLeft, secondsLeft])
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
