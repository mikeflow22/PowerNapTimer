//
//  TimerViewController.swift
//  PowerNapTimer
//
//  Created by Michael Flowers on 9/24/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit
import UserNotifications

class TimerViewController: UIViewController {

    let myTimer = TimerController()
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButtonProperties: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTimer.delegate = self
        updateViews()
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        if myTimer.isOn == true {
            myTimer.stopTimer()
            //handle later - notifications
        } else {
            myTimer.startTimer(10)
            //handle later - notifications
        }
        updateViews()
    }
    
    func updateViews(){
        updateTimerTextLabel()
        if myTimer.isOn {
            startButtonProperties.setTitle("Stop Timer", for: .normal)
        } else {
            startButtonProperties.setTitle("Start Nap", for: .normal)
        }
    }
    
    func updateTimerTextLabel(){
        //take the time remaning and set the label text
        timerLabel.text = myTimer.timeAsString()
    }
    
    func setUpAlertController(){
        var snoozeTextField: UITextField?
        let alert = UIAlertController(title: "Time to wake up", message: "blah blah blah", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Snooze for how long..."
            textField.keyboardType = .numberPad
            snoozeTextField = textField
        }
        let snoozeAction = UIAlertAction(title: "Snooze", style: .default) { (_) in
            guard let snoozeTimeText = snoozeTextField?.text,
                let time = TimeInterval(snoozeTimeText) else { return }
            self.myTimer.startTimer(time)
            self.updateViews()
            //handle notifications
        }
        
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel) { (_) in
            self.updateViews()
        }
        
        alert.addAction(snoozeAction)
        alert.addAction(dismissAction)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Notifications
    func scheduleNotification(){
       let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Wakey Wakey"
        notificationContent.body = "get that money, honey!"
        
        
        guard let timeRemaining = myTimer.timeRemaining else  { return }
        
        let fireDate = Date(timeInterval: timeRemaining, since: Date())
        let dateComponents = Calendar.current.dateComponents([.minute, .second], from: fireDate)
        let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let notificationRequest = UNNotificationRequest(identifier: userNotifictionIdentifier, content: notificationContent, trigger: notificationTrigger)
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription)\n~~~\n\(error)")
            }
        }
    }
    
    //move later
    fileprivate  let userNotifictionIdentifier = "timerNotification"
    
    func cancelNotification(){
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [userNotifictionIdentifier])
    }
}
extension TimerViewController: TimerDelegate {
    func timerSecondTick() {
        updateTimerTextLabel()
    }
    
    func timerCompleted() {
        updateViews()
        setUpAlertController()
        //handle notifications
    }
    
    func timerStopped() {
        updateViews()
        //fire the alert controller
    }
    
    
}
