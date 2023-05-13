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
    
    private func getOldChat()  {
        guard let chatId = chatId else {return}
        // getMessagesFromBackEnd
    }
    
    func getMessages() {
        ref =  Database.database(url: "https://golden-auctions.firebaseio.com/").reference().child("chats").child("\(CoreData.shared.loginModel?.id ?? 0)")
        handle = ref?.observe(.childAdded, with: {[weak self] snapShot in
            let data = snapShot.value as? NSDictionary
            guard let name = data?["userName"] as? String else{return}
            guard let date =  data?["date"] as? String else{return}
            guard let text = data?["messages"] as? String else {return}
            guard let senderType = data?["sender_Type"] as? String else {return}
            var message = Message(senderType: senderType, date: date, message: text, name: name)
            var chat = self?.messages.value
            chat?.append(message)
            self?.messages.accept(chat ?? [])
        })
    }
    
    private func sendMessage(message:Message) {
        let messageDictionary = ["sender_Type":message.senderType,"messages":message.message,"date":Date(),"userName":message.name] as [String : Any]
        Database.database().reference().child("chats").child("\(CoreData.shared.loginModel?.id ?? 0)").childByAutoId().setValue(messageDictionary)
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



