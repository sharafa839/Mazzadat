//
//  ISData.swift
//  Naseem
//
//  Created by Dev Anas on 4/1/19.
//  Copyright © 2019 Dev Anas. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
struct userOB {
    var id : Int?

    var email : String?
    var name : String?
    var mobile : String?
    var mobile_code : String?
    var device_token : String?
    var device_type : String?
    var app_locale : String?
    var points : Int?
    var right_expectations : Int?
    var wrong_expectations : Int?
    var avatar : String?
    var access_token : String?
    var email_verified_at: String?
    var is_subscribed : Bool?
    var subscription_count : String?
    var notification_count : String?
    var mySubscribes : Array<MySubscribeOB>!


    init(dictionary : Dictionary<String , Any>) {
        email = dictionary["email"] as? String ?? ""
        access_token = dictionary["access_token"] as? String ?? ""

        name = dictionary["name"] as? String ?? ""
        email_verified_at = dictionary["email_verified_at"] as? String ?? ""

        mobile = dictionary["mobile"] as? String ?? ""
        mobile_code = dictionary["mobile_code"] as? String ?? ""
        device_token = dictionary["device_token"] as? String ?? ""
        device_type = dictionary["device_type"] as? String ?? ""
        app_locale = dictionary["app_locale"] as? String ?? ""
        points = dictionary["points"] as? Int ?? 0
        email = dictionary["email"] as? String ?? ""
        right_expectations = dictionary["right_expectations"] as? Int ?? 0
        wrong_expectations = dictionary["wrong_expectations"] as? Int ?? 0
        avatar = dictionary["avatar"] as? String ?? ""
        id = dictionary["id"] as? Int ?? 0
        is_subscribed = dictionary["is_subscribed"] as? Bool ?? false
        
        
        
                if let value = dictionary["Subscriptions"] as? Array<Dictionary<String, AnyObject>> {
                          mySubscribes = []
                          for itemDic in value {
                              let item = MySubscribeOB(dictionary:itemDic)
                            mySubscribes.append(item)
                          }
                      }
}
}
    struct clubOB {
        
        var id : Int?
        var name : String?
        var logo : String?
        
        init(dictionary : Dictionary<String , Any>) {
            id = dictionary["id"] as? Int ?? 0
            name = dictionary["name"] as? String ?? ""
            logo = dictionary["logo"] as? String? ?? ""
        }
    }


    struct settingOB {
        
        var privacy : String?
        var about : String?
        var email : String?
        var mobile : String?
        var terms : String?
        var facebook : String?

        var in_app_purchase_apple : String?

        
 
        
        init(dictionary : Dictionary<String , Any>) {
  
            privacy = dictionary["privacy"] as? String ?? ""
         about = dictionary["about"] as? String ?? ""
            email = dictionary["email"] as? String ?? ""
            mobile = dictionary["mobile"] as? String ?? ""
            terms = dictionary["terms"] as? String ?? ""

            facebook = dictionary["facebook"] as? String ?? ""
            in_app_purchase_apple = dictionary["in_app_purchase_apple"] as? String ?? ""

        }
    }


   struct SubscriptionsOB {
       
    var id : Int?
    var name : String?
    var description : String?
    var price : String?
    var gained_balance : String?

       init(dictionary : Dictionary<String , Any>) {
        id = dictionary["id"] as? Int ?? 0
        name = dictionary["name"] as? String ?? ""
        description = dictionary["description"] as? String ?? ""
        price = dictionary["price"] as? String ?? ""
        gained_balance = dictionary["gained_balance"] as? String ?? ""
       }
   }



  struct BanckAcountsOB {
      
        var id : Int?
      var bank_name : String?
      var account_name : String?
      var account_number : String?
      var account_iban : String?
    
    
      init(dictionary : Dictionary<String , Any>) {
       bank_name = dictionary["bank_name"] as? String ?? ""
       account_name = dictionary["account_name"] as? String ?? ""
        account_number = dictionary["account_number"] as? String ?? ""
        account_iban = dictionary["account_iban"] as? String ?? ""
      }
  }

struct CategoryOB {
    
      var id : Int?
    var name : String?
    var image : String?
    var auction_count : Int?

  
    init(dictionary : Dictionary<String , Any>) {
     id = dictionary["id"] as? Int ?? 0
     name = dictionary["name"] as? String ?? ""
      image = dictionary["image"] as? String ?? ""
        auction_count = dictionary["auction_count"] as? Int ?? -1

    }
}

struct QestionOB {
    
      var id : Int?
    var name : String?
    var image : String?
    var faqInfo: [FaqsOB] = []

    init(dictionary : Dictionary<String , Any>) {
     id = dictionary["id"] as? Int ?? 0
     name = dictionary["name"] as? String ?? ""
      image = dictionary["image"] as? String ?? ""
        
        if let value = dictionary["Faqs"] as? Array<Dictionary<String, AnyObject>> {
            
            faqInfo = []
            for itemDic in value {
                let item = FaqsOB(dictionary:itemDic)
                faqInfo.append(item)
            }
                 
              }
    }
}


struct FaqsOB {
    
      var id : Int?
    var question : String?
    var answer : String?
    
  
    init(dictionary : Dictionary<String , Any>) {
     id = dictionary["id"] as? Int ?? 0
        question = dictionary["question"] as? String ?? ""
        answer = dictionary["answer"] as? String ?? ""
        
       
    }
}
struct DocOB {
    
    var id : Int?
    var document_type_id : Int?
    var expiry_date : String?
    var front_face : String?
    var back_face : String?
    var name : String?
    var image : String?
    
    var docType:DocumentTypeOB?
  
    init(dictionary : Dictionary<String , Any>) {
     id = dictionary["id"] as? Int ?? 0
        document_type_id = dictionary["document_type_id"] as? Int ?? 0
     expiry_date = dictionary["expiry_date"] as? String ?? ""
        name = dictionary["name"] as? String ?? ""
        front_face = dictionary["front_face"] as? String ?? ""
        back_face = dictionary["back_face"] as? String ?? ""

      image = dictionary["image"] as? String ?? ""
        if let value = dictionary["DocumentType"] as? Dictionary<String, AnyObject> {
           let item = DocumentTypeOB(dictionary:value)
           docType = item
                    }
    
    }
}

struct DocumentTypeOB {
    
      var id : Int?
    var name : String?
    var image : String?
  
    init(dictionary : Dictionary<String , Any>) {
     id = dictionary["id"] as? Int ?? 0
     name = dictionary["name"] as? String ?? ""
      image = dictionary["image"] as? String ?? ""
    }
}


struct MySubscribeOB {
    
      var id : Int?
    var type : Int?
    var value : Int?
  var status : Int
    var name : String?
    var description : String?
    var price : String?
    var gained_balance : String?

    
    init(dictionary : Dictionary<String , Any>) {
     id = dictionary["id"] as? Int ?? 0
        type = dictionary["type"] as? Int ?? 0
        value = dictionary["value"] as? Int ?? 0
        status = dictionary["status"] as? Int ?? 0
        name = dictionary["name"] as? String ?? ""
        description = dictionary["description"] as? String ?? ""
        price = dictionary["price"] as? String ?? ""
        gained_balance = dictionary["gained_balance"] as? String ?? ""
    }
}



struct SubscribeOB {
    
      var id : Int?
    var name : String?
    var description : String?
  var price : String?
    var gained_balance : String?

    init(dictionary : Dictionary<String , Any>) {
     id = dictionary["id"] as? Int ?? 0
     name = dictionary["name"] as? String ?? ""
      description = dictionary["description"] as? String ?? ""
        price = dictionary["price"] as? String ?? ""
        gained_balance = dictionary["gained_balance"] as? String ?? ""

 
    }
}


struct TikectOB {
    
      var id : Int?
    var title : String?
    var message : String?
  var attachment : String?
    var status : Int?
    
    var tikectArry : Array<TikectResponseOB>!


    init(dictionary : Dictionary<String , Any>) {
     id = dictionary["id"] as? Int ?? 0
     title = dictionary["title"] as? String ?? ""
      message = dictionary["message"] as? String ?? ""
        attachment = dictionary["attachment"] as? String ?? ""
        status = dictionary["status"] as? Int ?? -1
        
        
                if let value = dictionary["TicketResponses"] as? Array<Dictionary<String, AnyObject>> {
                          tikectArry = []
                          for itemDic in value {
                              let item = TikectResponseOB(dictionary:itemDic)
                              tikectArry.append(item)
                          }
                      }
 
    }
}

struct TikectResponseOB {
    
    var id : Int?
    var response : String?
    var sender_type : Int?

    init(dictionary : Dictionary<String , Any>) {
     id = dictionary["id"] as? Int ?? 0
     response = dictionary["response"] as? String ?? ""
      sender_type = dictionary["sender_type"] as? Int ?? 0
    }
}

struct banksOB {
    
      var id : Int?
    var bank_name : String?
    var account_name : String?
  var account_number : String?
    var account_iban : String?

    init(dictionary : Dictionary<String , Any>) {
     id = dictionary["id"] as? Int ?? 0
     bank_name = dictionary["bank_name"] as? String ?? ""
     account_number = dictionary["account_number"] as? String ?? ""
    account_iban = dictionary["account_iban"] as? String ?? ""
        account_name = dictionary["account_name"] as? String ?? ""

    }
}





struct MediaOB {
    
      var id : Int?
    var file : String?
    var media_type : Int?
  
    init(dictionary : Dictionary<String , Any>) {
     id = dictionary["id"] as? Int ?? 0
     file = dictionary["file"] as? String ?? ""
      media_type = dictionary["media_type"] as? Int ?? 0
    }
}

struct AuctionsOB {
    
    var id : Int?
    var category_id : Int?
    var city_id : Int?
    var name: String?
    var description: String?
    var lat: String!
    var lng: String!
    var price: String?
    var minimum_bid: String?
    var code: String?
    var end_at: String?
    var bids_count: Int?
    var LastBid: lastBidOB?
    var is_favourite: Bool?
    var lang : Double?
    var late: Double?
    var catData : CategoryOB?
    var mediaArry : Array<MediaOB>!
    var AuctionDet : Array<AuctionDetialsOB>!

    var status : Int?

    var user_id: String?
    var time : Timestamp?
    var terms_conditions: String?
    var userName: String?

    var start_at: String?


    var cityData : CitiesOB?

  
    init(dictionary : Dictionary<String , Any>) {
     id = dictionary["id"] as? Int ?? 0
        status = dictionary["status"] as? Int ?? 0

        name = dictionary["name"] as? String ?? ""
        description = dictionary["description"] as? String ?? ""
        lat = dictionary["lat"] as? String ?? ""
        lng = dictionary["lng"] as? String ?? ""
        price = dictionary["price"] as? String ?? ""
        minimum_bid = dictionary["minimum_bid"] as? String ?? ""
        code = dictionary["code"] as? String ?? ""
        end_at = dictionary["end_at"] as? String ?? ""
        
                start_at  = dictionary["start_at"] as? String ?? ""

        
        bids_count = dictionary["bids_count"] as? Int ?? 0
        time = dictionary["creationDate"] as? Timestamp 
        user_id = dictionary["user_id"] as? String ?? "" 
        terms_conditions = dictionary["terms_conditions"] as? String ?? ""
        userName = dictionary["userName"] as? String ?? ""

        lang =  Double(lng) ?? 0.0
        late =  Double(lat) ?? 0.0
    is_favourite = dictionary["is_favourite"] as? Bool ?? false

     category_id = dictionary["category_id"] as? Int ?? 0
        city_id = dictionary["city_id"] as? Int ?? 0

      if let value = dictionary["Category"] as? Dictionary<String, AnyObject> {
        let item = CategoryOB(dictionary:value)
        catData = item
                 }
        
        if let valueBid = dictionary["LastBid"] as? Dictionary<String, AnyObject> {
            let item = lastBidOB(dictionary:valueBid)
            LastBid = item
                     }
        
        if let value = dictionary["City"] as? Dictionary<String, AnyObject> {
               let item = CitiesOB(dictionary:value)
               cityData = item
                        }
        
        
        if let value = dictionary["Media"] as? Array<Dictionary<String, AnyObject>> {
                       mediaArry = []
                       for itemDic in value {
                           let item = MediaOB(dictionary:itemDic)
                           mediaArry.append(item)
                       }
                   }
        
        
        
        if let value = dictionary["AuctionDetails"] as? Array<Dictionary<String, AnyObject>> {
                            AuctionDet = []
                            for itemDic in value {
                                let item = AuctionDetialsOB(dictionary:itemDic)
                                AuctionDet.append(item)
                            }
                        }
        
    }
}


struct NotiOB {
    
    var id : Int?
    var title : String?
    var message : String?
    var ref_id : Int?
    var type : Int?
    var created_at : String?
    var read_at : String?

    init(dictionary : Dictionary<String , Any>) {
        
        id = dictionary["id"] as? Int ?? 0
        type = dictionary["type"] as? Int ?? 0
        ref_id = dictionary["ref_id"] as? Int ?? 0

        message = dictionary["message"] as? String ?? ""
        title = dictionary["title"] as? String ?? ""

        created_at = dictionary["created_at"] as? String ?? ""
        read_at = dictionary["read_at"] as? String ?? ""

//
//        if let value = dictionary["Cities"] as? Array<Dictionary<String, AnyObject>> {
//                  CitiesArry = []
//                  for itemDic in value {
//                      let item = CitiesOB(dictionary:itemDic)
//                      CitiesArry.append(item)
//                  }
//              }

    }
}


struct lastBidOB {
    
    var id : Int?
    var user_id : Int?
    var price : String?
    var user : Array<userOB>!
    
    init(dictionary : Dictionary<String , Any>) {
        
        id = dictionary["id"] as? Int ?? 0
        price = dictionary["price"] as? String ?? ""
        user_id = dictionary["user_id"] as? Int ?? 0

//
//        if let value = dictionary["Cities"] as? Array<Dictionary<String, AnyObject>> {
//                  CitiesArry = []
//                  for itemDic in value {
//                      let item = CitiesOB(dictionary:itemDic)
//                      CitiesArry.append(item)
//                  }
//              }

    }
}

struct CountriesOB {
    
    var id : Int?
    var name : String?
     var CitiesArry : Array<CitiesOB>!
    
    init(dictionary : Dictionary<String , Any>) {
        
        id = dictionary["id"] as? Int ?? 0
        name = dictionary["name"] as? String ?? ""
    
        if let value = dictionary["Cities"] as? Array<Dictionary<String, AnyObject>> {
                  CitiesArry = []
                  for itemDic in value {
                      let item = CitiesOB(dictionary:itemDic)
                      CitiesArry.append(item)
                  }
              }

    }
}


struct CitiesOB {
    var id : Int?
    var name : String?
    
    init(dictionary : Dictionary<String , Any>) {
        id = dictionary["id"] as? Int ?? 0
        name = dictionary["name"] as? String ?? ""
        
    }
}


struct AuctionDetialsOB {
    var id : Int?
    var name : String?
    var value : String?

    init(dictionary : Dictionary<String , Any>) {
        id = dictionary["id"] as? Int ?? 0
        name = dictionary["name"] as? String ?? ""
        value = dictionary["value"] as? String ?? ""
    }
}

struct DocumentsTypesOB {
    var id : Int?
    var name : String?
    var image : String?

    init(dictionary : Dictionary<String , Any>) {
        id = dictionary["id"] as? Int ?? 0
        name = dictionary["name"] as? String ?? ""
        image = dictionary["image"] as? String ?? ""
    }
}
//
//struct feeOB {
//
//    var class_fees : String?
//    var aboutUsImage : String?
//
//
//    var classesArry : Array<feeCalssOB>!
//    var FixedclassesArry : Array<fixedFeeCalssOB>!
//
//
//    init(dictionary : Dictionary<String , Any>) {
//        if let value = dictionary["feesClass"] as? Array<Dictionary<String, AnyObject>> {
//                 classesArry = []
//                 for itemDic in value {
//                     let item = feeCalssOB(dictionary:itemDic)
//                     classesArry.append(item)
//                 }
//             }
//
//        if let value = dictionary["feesFixed"] as? Array<Dictionary<String, AnyObject>> {
//                      FixedclassesArry = []
//                      for itemDic in value {
//                          let item = fixedFeeCalssOB(dictionary:itemDic)
//                          FixedclassesArry.append(item)
//                      }
//                  }
//
//    }
//}
//
//struct feeCalssOB {
//
//    var class_fees : String?
//
//    init(dictionary : Dictionary<String , Any>) {
//
//        class_fees = dictionary["class_fees"] as? String ?? ""
//    }
//}
//
//
//struct linkOB {
//
//    var facebook : String?
//    var twitter : String?
//    var linkedin : String?
//    var google : String?
//    var youtube : String?
//    var instagram : String?
//
//    init(dictionary : Dictionary<String , Any>) {
//
//        twitter = dictionary["twitter"] as? String ?? ""
//        facebook = dictionary["facebook"] as? String ?? ""
//        linkedin = dictionary["linkedin"] as? String ?? ""
//        google = dictionary["google"] as? String ?? ""
//        youtube = dictionary["youtube"] as? String ?? ""
//        instagram = dictionary["instagram"] as? String ?? ""
//
//    }
//}
//
//
//struct fixedFeeCalssOB {
//
//    var fees_value : String?
//    var fees_item_ar : String?
//    var fees_item_en : String?
//
//    init(dictionary : Dictionary<String , Any>) {
//
//        fees_value = dictionary["fees_value"] as? String ?? ""
//        fees_item_ar = dictionary["fees_item_ar"] as? String ?? ""
//        fees_item_en = dictionary["fees_item_en"] as? String ?? ""
//
//    }
//}
//struct teachersOB {
//
//    var name : String?
//
//
//
//    init(dictionary : Dictionary<String , Any>) {
//
//
//        name = dictionary["name"] as? String ?? ""
//
//    }
//}
//
//struct teacherDataOB {
//
//    var textTeacher : String?
//    var teacherArry : Array<teachersOB>!
//
//
//
//
//    init(dictionary : Dictionary<String , Any>) {
//
//        textTeacher = dictionary["textTeacher"] as? String ?? ""
//        if let value = dictionary["teachers"] as? Array<Dictionary<String, AnyObject>> {
//                        teacherArry = []
//                        for itemDic in value {
//                            let item = teachersOB(dictionary:itemDic)
//                            teacherArry.append(item)
//                        }
//                    }
//
//    }
//}
//
//struct aboutOB {
//
//    var aboutUs : String?
//    var aboutUsImage : String?
//    var imageUrl: URL?
//
//
//    init(dictionary : Dictionary<String , Any>) {
//
//        aboutUsImage = dictionary["aboutUsImage"] as? String ?? ""
//        aboutUs = dictionary["aboutUs"] as? String ?? ""
//
//        imageUrl = URL(string: "https://timetolearnsa.com/uploads/frontend/\(aboutUsImage?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")")
//
//    }
//}
//
//struct dashBoardOB {
//
//    var count_absense : Int?
//    var images_std : Int?
//    var events : Int?
//    var count_message : Int?
//    var homework : Int?
//    var amount : String?
//
//
//    init(dictionary : Dictionary<String , Any>) {
//
//        count_absense = dictionary["count_absense"] as? Int ?? 0
//        images_std = dictionary["images_std"] as? Int ?? 0
//        events = dictionary["events"] as? Int ?? 0
//        count_message = dictionary["count_message"] as? Int ?? 0
//        homework = dictionary["homework"] as? Int ?? 0
//        amount = dictionary["amount"] as? String ?? ""
//    }
//}
//
//
//struct paymentOB {
//
//    var invoice_id : String?
//    var student_id : String?
//    var invoice_no : String?
//    var title : String?
//    var amount : String?
//    var amount_paid : String?
//    var due : String?
//    var creation_timestamp : String?
//    var payment_timestamp : String?
//    var payment_method : String?
//    var payment_details : String?
//    var status : String?
//    var year : String?
//    var student_name : String?
//
//
//    init(dictionary : Dictionary<String , Any>) {
//
//        invoice_id = dictionary["invoice_id"] as? String ?? ""
//        student_id = dictionary["student_id"] as? String ?? ""
//        invoice_no = dictionary["invoice_no"] as? String ?? ""
//        title = dictionary["title"] as? String ?? ""
//        amount = dictionary["amount"] as? String ?? ""
//
//        amount_paid = dictionary["amount_paid"] as? String ?? ""
//        due = dictionary["due"] as? String ?? ""
//        creation_timestamp = dictionary["creation_timestamp"] as? String ?? ""
//        payment_timestamp = dictionary["payment_timestamp"] as? String ?? ""
//        payment_method = dictionary["payment_method"] as? String ?? ""
//        payment_details = dictionary["payment_details"] as? String ?? ""
//        status = dictionary["status"] as? String ?? ""
//        year = dictionary["year"] as? String ?? ""
//        student_name = dictionary["student_name"] as? String ?? ""
//
//
//
//    }
//}
//
//struct msgOB {
//
//    var message_thread_id : String?
//    var message_thread_code : String?
//    var sender : String?
//    var reciever : String?
//
//    var last_message_timestamp : String?
//    var message_id : String?
//    var title : String?
//    var timestamp : String?
//    var message : String?
//    var read_status : String?
//    var attached_file_name : String?
//
//    var users : userOB?
//
//
//    init(dictionary : Dictionary<String , Any>) {
//
//        if let value = dictionary["users"] as? Dictionary<String, AnyObject> {
//
//            let item = userOB(dictionary:value)
//
//            users=item
//
//        }
//
//
//        message_thread_id = dictionary["message_thread_id"] as? String? ?? ""
//        message_thread_code = dictionary["message_thread_code"] as? String? ?? ""
//        sender = dictionary["sender"] as? String? ?? ""
//        reciever = dictionary["reciever"] as? String? ?? ""
//        last_message_timestamp = dictionary["last_message_timestamp"] as? String? ?? ""
//        message_id = dictionary["message_id"] as? String? ?? ""
//        title = dictionary["title"] as? String? ?? ""
//        timestamp = dictionary["timestamp"] as? String? ?? ""
//        message = dictionary["message"] as? String? ?? ""
//
//        read_status = dictionary["read_status"] as? String? ?? ""
//        attached_file_name = dictionary["attached_file_name"] as? String? ?? ""
//    }
//}
//
//struct rciverOB {
//
//    var id : String?
//    var name : String?
//    var material : String?
//
//
//
//    init(dictionary : Dictionary<String , Any>) {
//
//        id = dictionary["id"] as? String? ?? ""
//        name = dictionary["name"] as? String? ?? ""
//        material = dictionary["material"] as? String? ?? ""
//    }
//}
//
//
//
//
//struct studentOB {
//
//
//      var email : String?
//    var student_id : String?
//
//     var authentication_key : String?
//     var login_type : String?
//     var parent_id : String?
//     var name : String?
//     var id_no : String?
//     var phone : String?
//     var another_phone : String?
//     var relative_relation : String?
//     var profession : String?
//     var address : String?
//
//     var sex : String?
//     var images : String?
//    var student_img_id : String?
//    var student_img_image : String?
//
//     var class_name : String?
//     var section_name : String?
//     var birthday : String?
//     var student_code : String?
//    var image_qr : String?
//
//
//     var car_no : String?
//
//    var imageUrl:URL?
//    var id : Int = 0
//
//    init(dictionary : Dictionary<String , Any>) {
//        birthday = dictionary["birthday"] as? String ?? ""
//        student_img_id = dictionary["student_img_id"] as? String ?? ""
//        student_img_image = dictionary["student_img_image"] as? String ?? ""
//        image_qr = dictionary["image_qr"] as? String ?? ""
//
//
//
//        imageUrl = URL(string: "https://timetolearnsa.com/uploads/frontend/gallery_images/\(student_img_image?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")")
//
//
//
//
//        student_id = dictionary["student_id"] as? String ?? ""
//        section_name = dictionary["section_name"] as? String ?? ""
//        phone = dictionary["phone"] as? String ?? ""
//
//      sex = dictionary["sex"] as? String ?? ""
//               class_name = dictionary["class_name"] as? String ?? ""
//               student_code = dictionary["student_code"] as? String ?? ""
//               car_no = dictionary["car_no"] as? String ?? ""
//               birthday = dictionary["birthday"] as? String ?? ""
//               name = dictionary["name"] as? String ?? ""
//
//               images = dictionary["images"] as? String ?? ""
//
//               email = dictionary["email"] as? String ?? ""
//               login_type = dictionary["login_type"] as? String ?? ""
//               authentication_key = dictionary["authentication_key"] as? String ?? ""
//               login_type = dictionary["login_type"] as? String ?? ""
//               parent_id = dictionary["parent_id"] as? String ?? ""
//               id_no = dictionary["id_no"] as? String ?? ""
//
//               relative_relation = dictionary["relative_relation"] as? String ?? ""
//               profession = dictionary["profession"] as? String ?? ""
//               address = dictionary["address"] as? String ?? ""
//
//               another_phone = dictionary["another_phone"] as? String ?? ""
//    }
//}
//
//
//
//struct activityOB {
//
//    var notice_id : String?
//      var notice_title : String?
//    var create_timestamp : String?
//    var notice : String?
//    var month : String?
//    var status : String?
//    var show_on_website : String?
//    var image : String?
//    var imageUrl:URL?
//
//
//    init(dictionary : Dictionary<String , Any>) {
//
//        notice_id = dictionary["notice_id"] as? String ?? ""
//         notice_title = dictionary["notice_title"] as? String ?? ""
//        create_timestamp = dictionary["create_timestamp"] as? String ?? ""
//        month = dictionary["month"] as? String ?? ""
//        status = dictionary["status"] as? String ?? ""
//        status = dictionary["status"] as? String ?? ""
//        show_on_website = dictionary["show_on_website"] as? String ?? ""
//        notice = dictionary["notice"] as? String ?? ""
//
//
//        image = dictionary["image"] as? String ?? ""
//
//        imageUrl = URL(string: "https://timetolearnsa.com/uploads/frontend/noticeboard/\(image?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")")
//
//    }
//}
//
//
//
//struct noticeOB {
//
//    var notice_id : String?
//    var notice_title : String?
//    var create_timestamp : String?
//    var month : String?
//    var status : String?
//    var show_on_website : String?
//    var image : String?
//
//
//
//
//    init(dictionary : Dictionary<String , Any>) {
//
//        notice_id = dictionary["notice_id"] as? String ?? ""
//      notice_title = dictionary["notice_title"] as? String ?? ""
//        create_timestamp = dictionary["create_timestamp"] as? String ?? ""
//        month = dictionary["month"] as? String ?? ""
//        status = dictionary["status"] as? String ?? ""
//        show_on_website = dictionary["show_on_website"] as? String ?? ""
//        image = dictionary["image"] as? String ?? ""
//
//
//    }
//}
//
//
//struct planOB {
//
//    var day : String?
//    var name_ar : String?
//
//    var subjectsData : Array<subjectOB>!
//
//
//
//    init(dictionary : Dictionary<String , Any>) {
//
//        day = dictionary["day"] as? String ?? ""
//        name_ar = dictionary["name_ar"] as? String ?? ""
//
//
//        if let value = dictionary["subjects"] as? Array<Dictionary<String, AnyObject>> {
//                  subjectsData = []
//                  for itemDic in value {
//                      let item = subjectOB(dictionary:itemDic)
//                      subjectsData.append(item)
//                  }
//              }
//    }
//}
//
//
//struct NotiOB {
//
//    var title : String?
//    var id : Int?
//    var desc : String?
//    var link_zoom : String?
//    var parent_id : String?
//    var is_read : String?
//    var created_on : String?
//    var TimeStamp : String?
//
//
//
//
//    init(dictionary : Dictionary<String , Any>) {
//
//        title = dictionary["title"] as? String ?? ""
//        desc = dictionary["desc"] as? String ?? ""
//        link_zoom = dictionary["link_zoom"] as? String ?? ""
//        parent_id = dictionary["parent_id"] as? String ?? ""
//        is_read = dictionary["is_read"] as? String ?? ""
//        created_on = dictionary["created_on"] as? String ?? ""
//        TimeStamp = dictionary["TimeStamp"] as? String ?? ""
//
//    }
//}
//
//struct weekOB {
//
//    var plan_id : String?
//    var week_no : String?
//    var period : String?
//
//    var daysData : Array<daysOB>!
//
//
//
//    init(dictionary : Dictionary<String , Any>) {
//
//        plan_id = dictionary["plan_id"] as? String ?? ""
//        week_no = dictionary["week_no"] as? String ?? ""
//        period = dictionary["period"] as? String ?? ""
//
//
//        if let value = dictionary["days"] as? Array<Dictionary<String, AnyObject>> {
//                  daysData = []
//                  for itemDic in value {
//                      let item = daysOB(dictionary:itemDic)
//                      daysData.append(item)
//                  }
//              }
//    }
//}
//
//
//struct subjecOB {
//
//    var subject : String?
//    var lesson : String?
//    var routine : String?
//
//    init(dictionary : Dictionary<String , Any>) {
//
//        subject = dictionary["subject"] as? String ?? ""
//        lesson = dictionary["lesson"] as? String ?? ""
//        routine = dictionary["routine"] as? String ?? ""
//
//    }
//}
//
//
//struct daysOB {
//
//    var date : String?
//    var day : String?
//    var day_ar : String?
//
//    var subjectData : Array<subjecOB>!
//
//
//    init(dictionary : Dictionary<String , Any>) {
//
//        date = dictionary["date"] as? String ?? ""
//        day = dictionary["day"] as? String ?? ""
//        day_ar = dictionary["day_ar"] as? String ?? ""
//
//
//        if let value = dictionary["subject"] as? Array<Dictionary<String, AnyObject>> {
//                  subjectData = []
//                  for itemDic in value {
//                      let item = subjecOB(dictionary:itemDic)
//                      subjectData.append(item)
//                  }
//              }
//    }
//}
//
//
//struct eventsOB {
//
//    var month : String?
//    var noticeData : Array<noticeOB>!
//
//
//
//    init(dictionary : Dictionary<String , Any>) {
//
//        month = dictionary["month"] as? String ?? ""
//        if let value = dictionary["notice"] as? Array<Dictionary<String, AnyObject>> {
//                  noticeData = []
//                  for itemDic in value {
//                      let item = noticeOB(dictionary:itemDic)
//                      noticeData.append(item)
//                  }
//              }
//    }
//}
//
//struct subjOB {
//
//    var subject_id : String?
//    var name : String?
//
//
//
//    init(dictionary : Dictionary<String , Any>) {
//
//        name = dictionary["name"] as? String ?? ""
//  subject_id = dictionary["subject_id"] as? String ?? ""
//
//    }
//}
//
//
//struct lessonsOB {
//
//    var subject_id : String?
//    var name : String?
//    var class_id : String?
//    var section_id : String?
//    var teacher_id : String?
//    var year : String?
//    var class_routine_id : String?
//    var zoomLink : String?
//    var youtube : String?
//    var time_start : String?
//    var time_end : String?
//    var time_start_min : String?
//    var time_end_min : String?
//    var day : String?
//    var fullTimeStart : String?
//    var Timestamp : String?
//
//
//
//
//    init(dictionary : Dictionary<String , Any>) {
//
//        subject_id = dictionary["subject_id"] as? String ?? ""
//     name = dictionary["name"] as? String ?? ""
//        class_id = dictionary["class_id"] as? String ?? ""
//        section_id = dictionary["subject_id"] as? String ?? ""
//        teacher_id = dictionary["teacher_id"] as? String ?? ""
//        year = dictionary["year"] as? String ?? ""
//        class_routine_id = dictionary["class_routine_id"] as? String ?? ""
//        zoomLink = dictionary["zoomLink"] as? String ?? ""
//        youtube = dictionary["youtube"] as? String ?? ""
//        time_start = dictionary["time_start"] as? String ?? ""
//        time_end = dictionary["time_end"] as? String ?? ""
//        time_start_min = dictionary["time_start_min"] as? String ?? ""
//        time_end_min = dictionary["time_end_min"] as? String ?? ""
//        day = dictionary["day"] as? String ?? ""
//        fullTimeStart = dictionary["fullTimeStart"] as? String ?? ""
//        Timestamp = dictionary["Timestamp"] as? String ?? ""
//
//
//    }
//}
//
//struct galaryOB {
//
//    var frontend_gallery_id : String?
//      var title_ar : String?
//    var description_ar : String?
//    var date_added : String?
//    var image : String?
//    var count_img : String?
//    var show_on_website : String?
//
//
//    init(dictionary : Dictionary<String , Any>) {
//
//        frontend_gallery_id = dictionary["frontend_gallery_id"] as? String ?? ""
//         title_ar = dictionary["title_ar"] as? String ?? ""
//        description_ar = dictionary["description_ar"] as? String ?? ""
//        date_added = dictionary["date_added"] as? String ?? ""
//        show_on_website = dictionary["show_on_website"] as? String ?? ""
//
//        image = dictionary["image"] as? String ?? ""
//        count_img = dictionary["count_img"] as? String ?? ""
//
//
//    }
//}
//
//struct matOB {
//
//    var day : String?
//      var name_ar : String?
//      var subjectData : Array<subjectOB>!
//
//
//    var id : Int = 0
//
//    init(dictionary : Dictionary<String , Any>) {
//
//        day = dictionary["day"] as? String ?? ""
//            name_ar = dictionary["name_ar"] as? String ?? ""
//
//            if let value = dictionary["subjects"] as? Array<Dictionary<String, AnyObject>> {
//                   subjectData = []
//                   for itemDic in value {
//                       let item = subjectOB(dictionary:itemDic)
//                       subjectData.append(item)
//                   }
//               }
//
//
//
//    }
//}
//
//
//struct subjectOB {
//
//    var document_id : String?
//    var title : String?
//   var description : String?
//    var file_name : String?
//    var file_type : String?
//    var class_id : String?
//    var teacher_id : String?
//    var day : String?
//    var subject_id : String?
//    var subject_name : String?
//    var teacher_name : String?
//    var timestamp : String?
//
//
//    var class_routine_id : String?
//    var time_start : String?
//    var time_end : String?
//    var time_start_min : String?
//    var time_end_min : String?
//    var year : String?
//
//
//    var id : Int = 0
//
//    init(dictionary : Dictionary<String , Any>) {
//
//        class_routine_id = dictionary["class_routine_id"] as? String ?? ""
//        time_start = dictionary["time_start"] as? String ?? ""
//        time_end = dictionary["time_end"] as? String ?? ""
//        time_start_min = dictionary["time_start_min"] as? String ?? ""
//        time_end_min = dictionary["time_end_min"] as? String ?? ""
//        year = dictionary["year"] as? String ?? ""
//
//
//
//        timestamp = dictionary["timestamp"] as? String ?? ""
//
//        subject_name = dictionary["subject_name"] as? String ?? ""
//
//        document_id = dictionary["document_id"] as? String ?? ""
//        title = dictionary["title"] as? String ?? ""
//        description = dictionary["description"] as? String ?? ""
//        file_name = dictionary["file_name"] as? String ?? ""
//        file_type = dictionary["file_type"] as? String ?? ""
//        class_id = dictionary["class_id"] as? String ?? ""
//        teacher_id = dictionary["teacher_id"] as? String ?? ""
//        day = dictionary["day"] as? String ?? ""
//        subject_id = dictionary["subject_id"] as? String ?? ""
//        teacher_name = dictionary["teacher_name"] as? String ?? ""
//    }
//}
//struct reportOB {
//
//    var evaluation_id : String?
//    var evaluation_std_id : String?
//    var evaluation_teacher_id : String?
//    var evaluation_item : String?
//    var evaluation_notes : String?
//    var evaluation_added_on : String?
//    var attendance_id : String?
//    var timestamp : String?
//    var year : String?
//    var class_id : String?
//    var section_id : String?
//    var student_id : String?
//    var class_routine_id : String?
//    var item : String?
//    var grade : String?
//    var status : String?
//
//
//
//
//    var id : Int = 0
//
//    init(dictionary : Dictionary<String , Any>) {
//        item = dictionary["item"] as? String ?? ""
//        grade = dictionary["grade"] as? String ?? ""
//
//        evaluation_id = dictionary["evaluation_id"] as? String ?? ""
//        evaluation_std_id = dictionary["evaluation_std_id"] as? String ?? ""
//
//        evaluation_teacher_id = dictionary["evaluation_teacher_id"] as? String ?? ""
//        evaluation_item = dictionary["evaluation_item"] as? String ?? ""
//        evaluation_notes = dictionary["evaluation_notes"] as? String ?? ""
//        evaluation_added_on = dictionary["evaluation_added_on"] as? String ?? ""
//        student_id = dictionary["student_id"] as? String ?? ""
//
//        attendance_id = dictionary["attendance_id"] as? String ?? ""
//        timestamp = dictionary["timestamp"] as? String ?? ""
//        year = dictionary["year"] as? String ?? ""
//
//        class_id = dictionary["class_id"] as? String ?? ""
//        section_id = dictionary["section_id"] as? String ?? ""
//        student_id = dictionary["student_id"] as? String ?? ""
//        class_routine_id = dictionary["class_routine_id"] as? String ?? ""
//        status = dictionary["status"] as? String ?? ""
//
//
//    }
//}
//
//
//
//
//struct HomeOB {
//
//    var name : String?
//    var email : String?
//    var mobile : String?
//    var token : String?
//    var ads_slider : Array<sliderOB>!
//    var categories : Array<categoriesOB>!
//    var recom_product : Array<productOB>!
//    var best_product : Array<productOB>!
//
//    var exclusive_product : exclusiveProductOB!
//    var id : Int = 0
//
//    init(dictionary : Dictionary<String , Any>) {
//
//
//        if let value = dictionary["ads_slider"] as? Array<Dictionary<String, AnyObject>> {
//            ads_slider = []
//            for itemDic in value {
//                let item = sliderOB(dictionary:itemDic)
//                ads_slider.append(item)
//            }
//        }
//
//
//        if let value = dictionary["categories"] as? Array<Dictionary<String, AnyObject>> {
//            categories = []
//            for itemDic in value {
//                let item = categoriesOB(dictionary:itemDic)
//                categories.append(item)
//            }
//        }
//
//
//
//        if let value = dictionary["recom_product"] as? Array<Dictionary<String, AnyObject>> {
//            recom_product = []
//            for itemDic in value {
//                let item = productOB(dictionary:itemDic)
//                recom_product.append(item)
//            }
//        }
//
//
//        if let value = dictionary["best_product"] as? Array<Dictionary<String, AnyObject>> {
//            best_product = []
//            for itemDic in value {
//                let item = productOB(dictionary:itemDic)
//                best_product.append(item)
//            }
//        }
//
//        if let value = dictionary["exclusive_product"] as? Dictionary<String, AnyObject> {
//
//            let item = exclusiveProductOB(dictionary:value)
//
//            exclusive_product=item
//
//        }
//
//
//    }
//}
//
//
//
//struct sliderOB {
//
//    var id  : Int = 0
//    var image : String?
//    var product_id  : Int = 0
//    var status_text : String?
//    var name : String?
//
//
//
//    init(dictionary : Dictionary<String , Any>) {
//
//        name = dictionary["name"] as? String ?? ""
//        image = dictionary["image"] as? String ?? ""
//        status_text = dictionary["status_text"] as? String ?? ""
//        id = dictionary["id"] as? Int ?? 0
//        product_id = dictionary["product_id"] as? Int ?? 0
//
//    }
//}
//
//struct categoriesOB {
//
//    var id  : Int = 0
//    var image : String?
//    var status_text : String?
//    var name : String?
//
//
//
//    init(dictionary : Dictionary<String , Any>) {
//
//        name = dictionary["name"] as? String ?? ""
//        image = dictionary["image"] as? String ?? ""
//        status_text = dictionary["status_text"] as? String ?? ""
//        id = dictionary["id"] as? Int ?? 0
//
//    }
//}
//
//
//struct itemOB {
//
//    var id  : Int = 0
//       var price  : Int = 0
//       var counter_order  : Int = 0
//
//       var sub_section_id  : Int = 0
//       var image : String?
//       var status_text : String?
//       var name : String?
//       var sales : Int = 0
//       var sale_percentage : String?
//       var sale_price : Int = 0
//       var expire_date : String?
//       var description : String?
//
//       var is_favorite : Bool?
//       var is_sales : Bool?
//
//
//    var products : productDetOB!
//    var details : detialsOB!
//    var product_details : product_detailsOB!
//    var Rating : RatingOB!
//    var imageArry : Array<imagesOB>!
//    var related_products : Array<productDetOB>!
//
//
//    init(dictionary : Dictionary<String , Any>) {
//
//
//        expire_date = dictionary["expire_date"] as? String ?? ""
//             sale_percentage = dictionary["sale_percentage"] as? String ?? ""
//             name = dictionary["name"] as? String ?? ""
//             image = dictionary["image"] as? String ?? ""
//             status_text = dictionary["status_text"] as? String ?? ""
//             id = dictionary["id"] as? Int ?? 0
//             price = dictionary["price"] as? Int ?? 0
//             sub_section_id = dictionary["sub_section_id"] as? Int ?? 0
//             sales = dictionary["sales"] as? Int ?? 0
//             sale_price = dictionary["sale_price"] as? Int ?? 0
//             is_favorite = dictionary["is_favorite"] as? Bool ?? false
//
//
//        if let value = dictionary["related_products"] as? Array<Dictionary<String, AnyObject>> {
//                   related_products = []
//                   for itemDic in value {
//                       let item = productDetOB(dictionary:itemDic)
//                       related_products.append(item)
//                   }
//               }
//        if let value = dictionary["details"] as? Dictionary<String, AnyObject> {
//
//            let item = detialsOB(dictionary:value)
//
//            details=item
//        }
//
//
//        if let value = dictionary["products"] as? Dictionary<String, AnyObject> {
//
//            let item = productDetOB(dictionary:value)
//
//            products=item
//
//        }
//
//
//        if let value = dictionary["product_details"] as? Dictionary<String, AnyObject> {
//
//                   let item = product_detailsOB(dictionary:value)
//
//                   product_details=item
//
//               }
//
//
//        if let value = dictionary["Rating"] as? Dictionary<String, AnyObject> {
//
//            let item = RatingOB(dictionary:value)
//
//            Rating=item
//
//        }
//    }
//}
//
//struct ordersOB {
//
//    var id  : Int = 0
//    var price  : Int = 0
//    var total_price  : Int = 0
//
//    var quantity  : Int = 0
//
//
//
//    var payment_method_id  : Int = 0
//
//    var image : String?
//    var category_name : String?
//
//
//    var order_no : String?
//
//
//    var transaction_id : Int = 0
//
//    var product_name : String?
//
//
//    var status : Int = 0
//
//    var user_id : Int = 0
//    var address_id : Int = 0
//
//    var product_id : Int = 0
//
//    var product_description : String?
//
//    var payment_method_name: String?
//    var full_address: String?
//
//    var product_image: String?
//    var imageArry : Array<imagesOB>!
//    var created_at: String?
//    var statuses: [String]=[]
//
//    var status_text: String?
//
//
//
//
//
//
//    init(dictionary : Dictionary<String , Any>) {
//        status_text = dictionary["status_text"] as? String ?? ""
//
//        statuses = dictionary["statuses"] as? [String] ?? []
//
//        full_address = dictionary["full_address"] as? String ?? ""
//        created_at = dictionary["created_at"] as? String ?? ""
//
//        payment_method_name = dictionary["payment_method_name"] as? String ?? ""
//
//        product_name = dictionary["product_name"] as? String ?? ""
//        product_description = dictionary["product_description"] as? String ?? ""
//        product_image = dictionary["product_image"] as? String ?? ""
//
//        image = dictionary["image"] as? String ?? ""
//        category_name = dictionary["category_name"] as? String ?? ""
//        id = dictionary["id"] as? Int ?? 0
//        user_id = dictionary["user_id"] as? Int ?? 0
//
//        address_id = dictionary["address_id"] as? Int ?? 0
//        status = dictionary["status"] as? Int ?? 0
//
//
//
//
//
//        status = dictionary["status"] as? Int ?? 0
//
//        transaction_id = dictionary["transaction_id"] as? Int ?? 0
//
//        price = dictionary["price"] as? Int ?? 0
//        quantity = dictionary["quantity"] as? Int ?? 0
//        total_price = dictionary["total_price"] as? Int ?? 0
//        payment_method_id = dictionary["payment_method_id"] as? Int ?? 0
//        order_no = dictionary["order_no"] as? String ?? ""
//        product_id = dictionary["product_id"] as? Int ?? 0
//
//        if let value = dictionary["images"] as? Array<Dictionary<String, AnyObject>> {
//            imageArry = []
//            for itemDic in value {
//                let item = imagesOB(dictionary:itemDic)
//                imageArry.append(item)
//            }
//        }
//
//    }
//}
//
//
//struct productDetOB {
//
//    var id  : Int = 0
//    var price  : Int = 0
//    var counter_order  : Int = 0
//
//    var sub_section_id  : Int = 0
//    var image : String?
//    var status_text : String?
//    var name : String?
//    var sales : Int = 0
//    var sale_percentage : String?
//    var sale_price : Int = 0
//    var expire_date : String?
//    var description : String?
//
//    var is_favorite : Bool?
//    var is_sales : Bool?
//
//    var imageArry : Array<imagesOB>!
//
//
//    init(dictionary : Dictionary<String , Any>) {
//        expire_date = dictionary["expire_date"] as? String ?? ""
//        sale_percentage = dictionary["sale_percentage"] as? String ?? ""
//        description = dictionary["description"] as? String ?? ""
//
//        name = dictionary["name"] as? String ?? ""
//        image = dictionary["image"] as? String ?? ""
//        status_text = dictionary["status_text"] as? String ?? ""
//        id = dictionary["id"] as? Int ?? 0
//        price = dictionary["price"] as? Int ?? 0
//        sub_section_id = dictionary["sub_section_id"] as? Int ?? 0
//        sales = dictionary["sales"] as? Int ?? 0
//        sale_price = dictionary["sale_price"] as? Int ?? 0
//        is_favorite = dictionary["is_favorite"] as? Bool ?? false
//
//        if let value = dictionary["images"] as? Array<Dictionary<String, AnyObject>> {
//            imageArry = []
//            for itemDic in value {
//                let item = imagesOB(dictionary:itemDic)
//                imageArry.append(item)
//            }
//        }
//
//    }
//}
//
//
//struct imagesOB {
//    var image : String?
//    init(dictionary : Dictionary<String , Any>) {
//        image = dictionary["image"] as? String ?? ""
//    }
//}
//
//struct detialsOB {
//    var color : String?
//    var size : String?
//    var quantity : String
//
//    init(dictionary : Dictionary<String , Any>) {
//        color = dictionary["color"] as? String ?? ""
//        size = dictionary["size"] as? String ?? ""
//        quantity = dictionary["quantity"] as? String ?? ""
//
//    }
//}
//
//
//struct product_detailsOB {
//
//    var value : String?
//    var key : String?
//
//    init(dictionary : Dictionary<String , Any>) {
//        value = dictionary["value"] as? String ?? ""
//        key = dictionary["key"] as? String ?? ""
//
//    }
//}
//
//struct RatingOB {
//
//    var overall_evaluation : Double?
//    var Rating_total : Int?
//    var Rating_five_start : Int?
//    var Rating_four_start : Int?
//    var Rating_three_start : Int?
//    var Rating_two_start : Int?
//    var Rating_one_start : Int?
//
//    init(dictionary : Dictionary<String , Any>) {
//        overall_evaluation = dictionary["overall_evaluation"] as? Double ?? 0.0
//
//        Rating_total = dictionary["Rating_total"] as? Int ?? 0
//        Rating_five_start = dictionary["Rating_five_start"] as? Int ?? 0
//        Rating_four_start = dictionary["Rating_four_start"] as? Int ?? 0
//        Rating_three_start = dictionary["Rating_three_start"] as? Int ?? 0
//        Rating_two_start = dictionary["Rating_two_start"] as? Int ?? 0
//        Rating_one_start = dictionary["Rating_one_start"] as? Int ?? 0
//
//    }
//}
//
//
//struct relatedOB {
//
//    var id  : Int = 0
//    var price  : Int = 0
//    var counter_order  : Int = 0
//
//    var sub_section_id  : Int = 0
//    var image : String?
//    var name : String?
//
//    var status_text : String?
//    var sales : Int = 0
//    var sale_percentage : String?
//    var sale_price : Int = 0
//    var expire_date : String?
//    var description : String?
//
//    var is_favorite : Bool?
//    var is_sales : Bool?
//
//    var imageArry : Array<imagesOB>!
//
//
//    init(dictionary : Dictionary<String , Any>) {
//        expire_date = dictionary["expire_date"] as? String ?? ""
//        sale_percentage = dictionary["sale_percentage"] as? String ?? ""
//        name = dictionary["name"] as? String ?? ""
//        image = dictionary["image"] as? String ?? ""
//        status_text = dictionary["status_text"] as? String ?? ""
//        id = dictionary["id"] as? Int ?? 0
//        price = dictionary["price"] as? Int ?? 0
//        sub_section_id = dictionary["sub_section_id"] as? Int ?? 0
//        sales = dictionary["sales"] as? Int ?? 0
//        counter_order = dictionary["counter_order"] as? Int ?? 0
//
//        sale_price = dictionary["sale_price"] as? Int ?? 0
//        is_favorite = dictionary["is_favorite"] as? Bool ?? false
//
//        if let value = dictionary["images"] as? Array<Dictionary<String, AnyObject>> {
//            imageArry = []
//            for itemDic in value {
//                let item = imagesOB(dictionary:itemDic)
//                imageArry.append(item)
//            }
//        }
//
//    }
//}
//
//
//
//struct AdressOB {
//    var id: Int?
//    var name: String?
//    var mobile: String?
//    var countryID, cityID, areaID: Int?
//    var street: String?
//    var building, floor, flat: Int?
//    var lat, lng, note: String?
//    var userID: Int?
//    var createdAt, updatedAt: String?
//    var countryName, cityName, areaName, fullAddress: String?
//
//
//    init(dictionary : Dictionary<String , Any>) {
//         name = dictionary["name"] as? String ?? ""
//         mobile = dictionary["mobile"] as? String ?? ""
//        countryID = dictionary["country_id"] as? Int ?? 0
//
//        id = dictionary["id"] as? Int ?? 0
//
//        cityID = dictionary["city_id"] as? Int ?? 0
//        areaID = dictionary["area_id"] as? Int ?? 0
//        building = dictionary["building"] as? Int ?? 0
//        floor = dictionary["floor"] as? Int ?? 0
//        flat = dictionary["flat"] as? Int ?? 0
//        lat = dictionary["lat"] as? String ?? ""
//        lng = dictionary["lng"] as? String ?? ""
//        note = dictionary["note"] as? String ?? ""
//        userID = dictionary["userID"] as? Int ?? 0
//        createdAt = dictionary["createdAt"] as? String ?? ""
//        updatedAt = dictionary["updatedAt"] as? String ?? ""
//        countryName = dictionary["country_name"] as? String ?? ""
//        cityName = dictionary["city_name"] as? String ?? ""
//        areaName = dictionary["area_name"] as? String ?? ""
//        fullAddress = dictionary["full_address"] as? String ?? ""
//        street = dictionary["street"] as? String ?? ""
//
//     }
//}
//
//struct contryOB {
//
//    var id  : Int = 0
//
//    var status_text : String?
//
//    var name : String?
//
//    var areaArry : Array<areaOB>!
//
//
//
//    init(dictionary : Dictionary<String , Any>) {
//        name = dictionary["name"] as? String ?? ""
//        status_text = dictionary["status_text"] as? String ?? ""
//        id = dictionary["id"] as? Int ?? 0
//
//        if let value = dictionary["areas"] as? Array<Dictionary<String, AnyObject>> {
//                  areaArry = []
//                  for itemDic in value {
//                      let item = areaOB(dictionary:itemDic)
//                      areaArry.append(item)
//                  }
//              }
//
//    }
//}
//
//struct areaOB {
//
//    var id  : Int = 0
//
//    var status_text : String?
//
//    var country_name : String?
//    var city_name : String?
//    var name : String?
//
//
//    init(dictionary : Dictionary<String , Any>) {
//        country_name = dictionary["country_name"] as? String ?? ""
//        city_name = dictionary["city_name"] as? String ?? ""
//        name = dictionary["name"] as? String ?? ""
//
//        status_text = dictionary["status_text"] as? String ?? ""
//        id = dictionary["id"] as? Int ?? 0
//
//    }
//}
//
//
//struct productOB {
//
//    var id  : Int = 0
//    var price  : Int = 0
//    var sub_section_id  : Int = 0
//    var image : String?
//    var status_text : String?
//    var sales : Int = 0
//    var sale_percentage : String?
//    var sale_price : Int = 0
//    var expire_date : String?
//    var name : String?
//
//
//    init(dictionary : Dictionary<String , Any>) {
//        expire_date = dictionary["expire_date"] as? String ?? ""
//        sale_percentage = dictionary["sale_percentage"] as? String ?? ""
//        name = dictionary["name"] as? String ?? ""
//        image = dictionary["image"] as? String ?? ""
//        status_text = dictionary["status_text"] as? String ?? ""
//        id = dictionary["id"] as? Int ?? 0
//        price = dictionary["price"] as? Int ?? 0
//        sub_section_id = dictionary["sub_section_id"] as? Int ?? 0
//        sales = dictionary["sales"] as? Int ?? 0
//        sale_price = dictionary["sale_price"] as? Int ?? 0
//
//    }
//}
//
//
//struct sectionsOB {
//
//    var id  : Int = 0
//    var price  : Int = 0
//    var sub_section_id  : Int = 0
//    var image : String?
//    var label_image : String?
//
//
//    var status_text : String?
//    var sales : Int = 0
//    var sale_percentage : String?
//    var sale_price : Int = 0
//    var expire_date : String?
//    var name : String?
//
//    var category_id  : Int = 0
//    var section_id  : Int = 0
//    var options  : Int = 0
//    var category_name : String?
//
//    var section_name : String?
//    var has_sections : Bool?
//    var ads_slider : Array<sliderOB>!
//    var products : Array<productDetOB>!
//
//    init(dictionary : Dictionary<String , Any>) {
//        expire_date = dictionary["expire_date"] as? String ?? ""
//        sale_percentage = dictionary["sale_percentage"] as? String ?? ""
//        name = dictionary["name"] as? String ?? ""
//        label_image = dictionary["label_image"] as? String ?? ""
//
//        category_name = dictionary["category_name"] as? String ?? ""
//
//        has_sections = dictionary["has_sections"] as? Bool ?? false
//        section_name = dictionary["section_name"] as? String ?? ""
//
//        image = dictionary["image"] as? String ?? ""
//        status_text = dictionary["status_text"] as? String ?? ""
//        id = dictionary["id"] as? Int ?? 0
//        price = dictionary["price"] as? Int ?? 0
//        sub_section_id = dictionary["sub_section_id"] as? Int ?? 0
//
//        category_id = dictionary["category_id"] as? Int ?? 0
//
//        section_id = dictionary["section_id"] as? Int ?? 0
//
//        options = dictionary["options"] as? Int ?? 0
//
//        if let value = dictionary["sliders"] as? Array<Dictionary<String, AnyObject>> {
//            ads_slider = []
//            for itemDic in value {
//                let item = sliderOB(dictionary:itemDic)
//                ads_slider.append(item)
//            }
//        }
//
//        if let value = dictionary["products"] as? Array<Dictionary<String, AnyObject>> {
//            products = []
//            for itemDic in value {
//                let item = productDetOB(dictionary:itemDic)
//                products.append(item)
//            }
//        }
//
//
//
//
//
//
//        sales = dictionary["sales"] as? Int ?? 0
//        sale_price = dictionary["sale_price"] as? Int ?? 0
//
//    }
//}
//
//
//
//struct cartOB {
//
//    var user_id  : Int = 0
//    var product_id  : Int = 0
//    var quantity  : Int = 0
//    var product_name : String?
//    var product_description : String?
//    var price : Int = 0
//    var product_image : String?
//    var total : Int = 0
//   var product : productOB?
//
//
//
//    init(dictionary : Dictionary<String , Any>) {
//        product_name = dictionary["product_name"] as? String ?? ""
//        product_image = dictionary["product_image"] as? String ?? ""
//        product_description = dictionary["product_description"] as? String ?? ""
//        product_id = dictionary["product_id"] as? Int ?? 0
//        price = dictionary["price"] as? Int ?? 0
//        user_id = dictionary["user_id"] as? Int ?? 0
//        quantity = dictionary["quantity"] as? Int ?? 0
//        total = dictionary["total"] as? Int ?? 0
//
//        if let value = dictionary["product"] as?Dictionary<String, AnyObject> {
//
//                      let item = productOB(dictionary:value)
//                      product=item
//
//              }
//
//    }
//}
//
//
//
//
//
//
//
//
//struct recomeendOB {
//
//    var id  : Int = 0
//    var price  : Int = 0
//    var sub_section_id  : Int = 0
//    var image : String?
//    var status_text : String?
//    var sales : Int = 0
//    var sale_percentage : String?
//    var sale_price : Int = 0
//    var expire_date : String?
//    var name : String?
//
//
//    init(dictionary : Dictionary<String , Any>) {
//        expire_date = dictionary["expire_date"] as? String ?? ""
//        sale_percentage = dictionary["sale_percentage"] as? String ?? ""
//        name = dictionary["name"] as? String ?? ""
//        image = dictionary["image"] as? String ?? ""
//        status_text = dictionary["status_text"] as? String ?? ""
//        id = dictionary["id"] as? Int ?? 0
//        price = dictionary["price"] as? Int ?? 0
//        sub_section_id = dictionary["sub_section_id"] as? Int ?? 0
//        sales = dictionary["sales"] as? Int ?? 0
//        sale_price = dictionary["sale_price"] as? Int ?? 0
//
//    }
//}
//
//
//struct exclusiveProductOB {
//
//
//    var general_exp : String?
//    var products : Array<productOB>!
//
//
//
//    init(dictionary : Dictionary<String , Any>) {
//
//        if let value = dictionary["products"] as? Array<Dictionary<String, AnyObject>> {
//            products = []
//            for itemDic in value {
//                let item = productOB(dictionary:itemDic)
//                products.append(item)
//            }
//        }
//
//        general_exp = dictionary["general_exp"] as? String ?? ""
//
//
//    }
//}
//
