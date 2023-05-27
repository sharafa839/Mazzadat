//
//  ChatViewModel.swift
//  Mazadaat
//
//  Created by Sharaf on 13/05/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import Foundation
import Foundation
import RxRelay
import RxSwift
import FirebaseDatabase

class ChatViewModel:HomeNetworkingProtocol {
    let disposeBag = DisposeBag()
    var onError = PublishSubject<String>()
    var onLoading = BehaviorRelay<Bool>(value: false)
    var messages = BehaviorRelay<[Message]>(value: [])
    var message : Message?
    var chatId: String?
    var auctionId:String?
    var ref: DatabaseReference?
    var handle: DatabaseHandle?
    var ifChatAvailable = PublishSubject<Bool>()
    var name:String
    init(chatId:String?,auctionId:String? = nil,name:String) {
        self.chatId = chatId
        self.auctionId = auctionId
        self.name = name
    }
    
   
    func getMessages() {
        ref =  Database.database(url: "https://golden-auctions.firebaseio.com/").reference().child("chats").child("\(CoreData.shared.loginModel?.id ?? 0)")
        handle = ref?.observe(.childAdded) {[weak self] snapShot in
            guard let self = self else {return}

            guard let data = snapShot.value as? NSDictionary else {return}
            guard let name = data["user_name"] as? String else{return}
            guard let date =  data["date"] as? String else{return}
            guard let text = data["messages"] as? String else {return}
            guard let senderType = data["sender_type"] as? String else {return}
         
             message = Message(senderType: senderType, date: date, message: text, name: name)
            var chat = messages.value
            chat.append(Message(senderType: message?.senderType ?? "" , date: message?.date  ?? "", message: message?.message ?? "", name: message?.name ?? ""))
            messages.accept(chat)

        }
        
    }
    
     func sendMessage(message:Message) {
         let date = Date().toString(format: "yyyy/mm/dd")
         let messageDictionary = ["sender_Type":message.senderType,"messages":message.message,"date":date ?? "","userName":message.name] as [String : Any]
         Database.database().reference().child("chats").child("\(CoreData.shared.loginModel?.chat_id)").childByAutoId().setValue(messageDictionary)
    }
    
    func sendMessageToBackend(message:Message) {
        sendMessage(message: message.message, auctionId: auctionId) { [weak self] result in
            self?.onLoading.accept(false)
            switch result {
            case .success(let response):
                return
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            }
        }
    }
    
    func checkIfChatAvailable() {
        
    }
}

struct Message {
    var senderType:String
    var date:String
    var message:String
    var name:String
    
}
