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
    
    func secondTicking(){
        //want to see how much time is remaining
        guard let timeLeft = timeRemaining else { return }
        if timeLeft < 0 {
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
        
    }
    
    func stopTimer(){
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
