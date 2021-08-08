//
//  MyReservationOB.swift
//  Naseem
//
//  Created by Eleyan Saad on 8/29/19.
//  Copyright © 2019 Dev Anas. All rights reserved.
//
import Foundation
struct   MyReservationOB {
    
    var id : Int = 0
    var user_id : Int = 0
    var vendor_id : Int = 0
    let date : String
    let time : String
    let type : String
    var price : String
    let number_of_people : String
    let deposit :String
    let status : String
    let user_name : String
    let user_phone : String
    var user_id_number : Int = 0
    let order_rate : String
    let morning_start : String
    let morning_end : String
    let evening_start : String
    let evening_end : String
    let full_day_start : String
    let full_day_end : String
    let hour : String


    let note : String
    let date_of_accept : String
    let deleted_at : String
    let chalet_name : String
    let chalet_image : String
    
    
    
    init(dictionary : Dictionary<String , Any>) {
        
        id = dictionary["id"] as? Int ?? -1
        user_id = dictionary["user_id"] as? Int ?? -1
        vendor_id = dictionary["vendor_id"] as?  Int ?? -1
        date = dictionary["date"] as? String ?? ""
        time = dictionary["time"] as? String ?? ""
        type = dictionary["type"] as? String ?? ""
        price = dictionary["price"] as? String ?? ""
        number_of_people = dictionary["number_of_people"] as? String ?? ""
        deposit = dictionary["deposit"] as? String ?? ""
        status = dictionary["status"] as? String ?? ""
        user_name = dictionary["user_name"] as? String ?? ""
        user_phone = dictionary["user_phone"] as? String ?? ""
        user_id_number = dictionary["user_id_number"] as? Int ?? -1
        order_rate = dictionary["order_rate"] as? String ?? ""
        morning_start = dictionary["morning_start"] as? String ?? ""
        morning_end = dictionary["morning_end"] as? String ?? ""
        evening_start = dictionary["evening_start"] as? String ?? ""
        evening_end = dictionary["evening_end"] as? String ?? ""
        full_day_start = dictionary["full_day_start"] as? String ?? ""
        full_day_end = dictionary["full_day_end"] as? String ?? ""
        chalet_image = dictionary["chalet_image"] as? String ?? ""
        chalet_name = dictionary["chalet_name"] as? String ?? ""
        note = dictionary["note"] as? String ?? ""
        date_of_accept = dictionary["date_of_accept"] as? String ?? ""
        deleted_at = dictionary["deleted_at"] as? String ?? ""
        hour = dictionary["hour"] as? String ?? ""


        
    }
}
