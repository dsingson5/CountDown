//
//  ViewController.swift
//  Count Down
//
//  Created by David Singson on 10/19/14.
//  Copyright (c) 2014 David Singson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var dateFormatter = NSDateFormatter()
    
    var startDate: NSDate?
    var futureTime: NSDate?
    
    var timer: NSTimer?
    
    var duration:NSTimeInterval?

    
    @IBOutlet var datePickerLabel: UIDatePicker!
    
    
    
    @IBAction func datePickerValueChanged(sender: AnyObject) {
        
        futureTime = datePickerLabel.date
        
        startDate = NSDate()
        
//        var now = NSDate()
        
//        var nowDuration = NSDate().timeIntervalSinceDate(now)
        
//        var duration = futureTime!.timeIntervalSinceDate(NSDate())
        
        
        var calendar:NSCalendar = NSCalendar.currentCalendar()
        
        let dayComponents = calendar.components(.CalendarUnitDay,
            fromDate: startDate!,
            toDate: futureTime!,
            options: nil)
        let dayDuration = dayComponents.day
        
        
        duration = futureTime!.timeIntervalSinceDate(startDate!)
        
        timeLabel.text = dateStringFromTimeInterval(duration!)
        dateLabel.text = "\(dayDuration)day/s"
        
        

        

    }
    
    
    @IBAction func startCountingButton(sender: AnyObject) {
        
        if timer == nil { //This create only one time not multiple timers! is a check has the timer started. //Start a timer!
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("updateTimer:"), userInfo: nil, repeats: true)
            
            
        } else {
            //don't start a timer
        }
        
        
    }
    
    func updateTimer(myTimer: NSTimer) { //this is a function call so you need to have "()"
        //        println("\(myTimer.timeInterval)")
        
        startDate = NSDate()
        
        futureTime = datePickerLabel.date
        
        if futureTime != nil {
            var duration = futureTime!.timeIntervalSinceDate(startDate!)
            //            println("duration: \(duration!)")
            
            
            timeLabel.text = dateStringFromTimeInterval(duration)
            
        }
        
    }
    
    
    func dateStringFromTimeInterval(timeInterval: NSTimeInterval) -> String {
        //Formatting the time to fit our style
        dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss.SS"
        //      timeLabel.text = dateFormatter.stringFromDate(currentTime!) //This is how you make a clock for the current time.
        
        //We have to create a new time zone for our dateformatter to UTC that will change our current time zone down to a zero because the UTC time zone is zero difference and cental time zone is +18! so usually stop timers are set to UTC so that the time zone is zero! :D
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        
        //We are shifting the date back in time where the time began for computer 1970 when UTC standard is approved
        var date = NSDate(timeIntervalSince1970: timeInterval)
        
        return dateFormatter.stringFromDate(date)
        
    }
    
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        timeLabel.text = dateStringFromTimeInterval(0)
        dateLabel.text = "0day/s"
        
        
        // Set min/max date for the date picker.
        // As an example we will limit the date between now and 7 days from now.
        let now = NSDate()
        datePickerLabel.minimumDate = now
        let currentCalendar = NSCalendar.currentCalendar()
        
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

