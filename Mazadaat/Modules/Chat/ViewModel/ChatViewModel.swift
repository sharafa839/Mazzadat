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

class ChatViewModel:HomeNetworkingProtocol,TicketNetworkingProtocol {
    let disposeBag = DisposeBag()
    var onError = PublishSubject<String>()
    var onLoading = BehaviorRelay<Bool>(value: false)
    var messages = BehaviorRelay<[Message]>(value: [])
    var onSuccess =  PublishSubject<Void>()
    var message : Message?
    var chatId: String?
    var auctionId:String?
    var ref: DatabaseReference?
    var handle: DatabaseHandle?
    var ifChatAvailable = PublishSubject<Bool>()
    var name:String
    var ticketId:String
    init(chatId:String?,auctionId:String? = nil,name:String) {
        self.chatId = chatId
        self.auctionId = auctionId
        self.name = name
        self.ticketId = ""
       
    }
    
  convenience init(ticketId:String) {
      self.init(chatId: "", name: "")
        self.ticketId = ticketId
        getTicketResponse()
    }
    
    func getTicketResponse() {
        show(id: ticketId) { [weak self] result in
            self?.onLoading.accept(false)
            switch result {
            case .success(let response):
                guard let ticketResponse = response.response?.data?.ticketResponses else {return}
                let ticketMessages = ticketResponse.map({$0.toMesssageModel})
                self?.messages.accept(ticketMessages)
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            }
        }
    }
    
     func sendTicketResponse(message:Message) {
        response(id: ticketId, response: message.message) { [weak self] result in
            self?.onLoading.accept(false)
            switch result {
            case .success(let response):
                guard let ticketChat = response.response?.data?.ticketResponses else {return}
                let ticketMessages = ticketChat.map({$0.toMesssageModel})
                self?.messages.accept(ticketMessages)
               // self?.onSuccess.onNext(())
            case .failure(let error):
                self?.onError.onNext(error.localizedDescription)
            }
        }
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
    init(senderType:String,date:String,message:String,name:String) {
        self.date = date
        self.message = message
        self.name = name
        self.senderType = senderType
    }
    
    init(_ model:TicketResponse) {
        self.senderType = "\(model.senderType ?? 0)"
        self.date = ""
        self.message = model.response ?? ""
        self.name = ""
    }
    
}
