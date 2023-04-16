//
//  TimerManager.swift
//  QosoorApp
//
//  Created by mac on 7/13/20.
//  Copyright © 2020 Ammar AlTahhan. All rights reserved.
//

import Foundation
import UIKit
import SwiftDate
class TimerManagerr {
    

    typealias Tick = (String, String, String, String, Bool) -> Void
    typealias HideOffer = (Bool) -> Void

    var timer: Timer?
    var interval: TimeInterval /*in seconds*/
    var repeats: Bool
    var tick: Tick
    var endDate: String?
    var isHideen: Bool?
    var timerStop: Bool?
    
    init( interval: TimeInterval ,endDate: String, stopTimer: Bool,repeats: Bool = false, onTick: @escaping Tick){
      
        
        self.interval = interval
        self.repeats = repeats
        self.tick = onTick
        self.endDate = endDate
        self.timerStop = stopTimer
    }
    
    func start(){

        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(update), userInfo: nil, repeats: true)//swift 3 upgrade
    }
    
     func stopTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    
    @objc func stop() {


       stopTimer()
        tick("0", "0", "0", "0", true )

    }
    
    @objc func update() {
        
        
        
        if timerStop == true {
            tick("0", "0", "0", "0",true)
return
        }
//        let d = (endDate?.toDate()
        var calendar = Calendar.current

        let endDatee = self.endDate?.toDateNew()
        
//        if timerStop == true {
//            timer?.invalidate()
//            return
//        }
        
        let timeInterval = calendar.dateComponents([.day, .hour, .minute, .second], from: Date(), to: endDatee! )
            
//            if  timeInterval.isValidDate{
                print("Viald")

           
            
            let days = "\(timeInterval.day ?? 0)"
            let hours = " \(timeInterval.hour  ?? 0)"
         
            let minutes = " \(timeInterval.minute ?? 0)"
            let seconds = " \(timeInterval.second ?? 0)"
         
    //
    //        if days <= "0" && hours <= "0" && minutes <= "0" {
    //            stopTimer()
    //            isHideen = true
    //        }
            tick(days, hours, minutes, seconds, isHideen ?? false)
        

        
        
//        let nowD = Date().toString(format: .custom(Constants.DateFormat.personalizedOfferDateFormat))
////        let calendar = Calendar.current
//        let currentDate = nowD.toDate(withFormat: Constants.DateFormat.personalizedOfferDateFormat)!
//        let endtDatee =  (endDate?.toDate(withFormat: Constants.DateFormat.personalizedOfferDateFormat))!

        //timer interval between current date and offer end date!
       

    }
}

extension String {
    func getDate()-> (day:String,hour:String,minute:String) {
        guard let date = self.toDateNew() else {return ("","","")}
        let calendar = Calendar.current
        let executiveDate = calendar.dateComponents([.day,.hour,.minute], from: date)
        return ("\(executiveDate.day ?? 0)","\(executiveDate.hour ?? 0)","\(executiveDate.minute ?? 0)")
        
    }
}
