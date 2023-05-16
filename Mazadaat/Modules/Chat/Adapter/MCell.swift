//
//  MCell.swift
//  SammaDriver
//
//  Created by ahmed on 5/15/21.
//

import UIKit

class MCell: UITableViewCell {

    
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageDateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func configure(message: Message){
        let text = message.message
        let senderType = UserType(rawValue: message.senderType) ?? .user
        messageLabel.text = text
        messageView.backgroundColor = senderType.messageContainerColor
        contentStackView.alignment = senderType.alignment
//
//         let view = stackView.subviews[senderType == .user ? 1 : 0]
//            stackView.addArrangedSubview(view)
//
//
//        if text.isPhoneNumber, text.count < 13, text.count > 3 {
//            messageLabel.textColor = .blue
//            let longGesture = UILongPressGestureRecognizer(target: self, action:#selector(longTap))
//            addGestureRecognizer(longGesture)
//        } else {
//            messageLabel.textColor = senderType.messageTextColor
//        }
//        if let url = URL(string: text), UIApplication.shared.canOpenURL(url) {
//            messageLabel.textColor = .blue
//        } else {
//            messageLabel.textColor = senderType.messageTextColor
//        }
//  
//        messageLabel.text = text
//        let date = message.date.toDateNew(withFormat: "yyyy/mmm/dd")
//        messageDateLabel.text = date?.toString(format: "yyyy/mmm/dd")
    }
    
   
}


enum UserType: String {
    case user = "user"
    case admin = "admin"
    
    
    var messageTextColor: UIColor {
        switch self {
        case .user: return .white
        default: return .textColor
        }
    }
    
    var messageContainerColor: UIColor {
        switch self {
        case .user: return .Bronze_500
        default: return .Bronze_100
        }
    }
    
    var alignment: UIStackView.Alignment {
        switch self {
        case .user: return .trailing
        default: return .leading
        }
    }
  
}

public extension String {
    
    var isPhoneNumber: Bool {
        let char  = NSCharacterSet(charactersIn: "+0123456789").inverted
        var filtered:NSString!
        let inputString = self.components(separatedBy: char)
        filtered = inputString.joined(separator: "") as NSString
        return  self == filtered as String
    }
}
