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
        let alarmDate = date_picker.date;
        date_tv.text = alarmDate.description(with: date_picker.locale);
        timer = Timer.init(fire: alarmDate, interval: TimeInterval.init(20), repeats: false, block: { (t) in
            self.date_tv.text = "The alarm has gone off";
        })
        if let timernew = timer {
            RunLoop.current.add(timernew, forMode: RunLoopMode.defaultRunLoopMode);
        }
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
