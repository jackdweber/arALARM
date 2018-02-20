//
//  SetAlarmViewController.swift
//  alarm
//
//  Created by Jack Weber on 2/15/18.
//  Copyright © 2018 Jack Weber. All rights reserved.
//

import UIKit

class SetAlarmViewController: UIViewController {
    
    @IBOutlet var date_picker: UIDatePicker!
    @IBOutlet var date_tv: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    var alarmSet = false
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setAlarm(_ sender: Any) {
        
        if !alarmSet {
            
            //Create the alarm logic
            checkIfNewUser()
            let alarmDate = date_picker.date;
            date_tv.text = alarmDate.description(with: date_picker.locale);
            timer = Timer.init(fire: alarmDate, interval: TimeInterval.init(20), repeats: false, block: { (t) in
                self.alarmRing()
            })
            if let timernew = timer {
                RunLoop.current.add(timernew, forMode: RunLoopMode.defaultRunLoopMode);
            }
            
            //Update the model and view
            //startButton.tintColor = UIColor.red
            startButton.setTitle("Cancel", for: .normal)
            startButton.layer.cornerRadius = 5
            alarmSet = true
            
        } else {
            if let t = timer{
                t.invalidate()
                //Update the model and view
                //self.startButton.tintColor = UIColor.blue
                self.startButton.setTitle("Start Alarm", for: .normal)
                self.date_tv.text = "No Current Alarm"
                alarmSet = false
            }
        }
        
    }
    
    func checkIfNewUser(){
        
        //Set up User Defaults
        let defaults = UserDefaults.standard
        
        //Create the alert
        let alertbox = UIAlertController.init(title: "Warning", message: "Please do not switch to another app after setting the alarm.\n If you do the alarm may not go off reliably.\n Would you like to be warned again?", preferredStyle: .alert)
        alertbox.addAction(UIAlertAction.init(title: "Warn me again", style: .default, handler: { (ui) in
            defaults.setValue("true", forKey: "newUser")
        }))
        alertbox.addAction(UIAlertAction.init(title: "Don't warn again", style: .destructive, handler: { (ui) in
            defaults.setValue("false", forKey: "newUser")
        }))
        
        //Show or don't show the alert
        if let newUser = defaults.value(forKey: "newUser") as? String {
            if newUser == "false" {
                
            } else {
                self.present(alertbox, animated: true, completion: {})
            }
        } else {
            self.present(alertbox, animated: true, completion: {})
        }
    }
    
    func alarmRing(){
        self.date_tv.text = "The alarm has gone off";
        //self.startButton.tintColor = UIColor.
        self.startButton.setTitle("Start Alarm", for: .normal)
        self.date_tv.text = "No Current Alarm"
        alarmSet = false
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
