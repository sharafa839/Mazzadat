//
//  MCell.swift
//  SammaDriver
//
//  Created by ahmed on 5/15/21.
//

import UIKit

class MCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet weak var messageBubble: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        messageBubble.roundCorners( radius: 20)
        messageBubble.backgroundColor = UIColor(red: 0.02, green: 0.36, blue: 0.62, alpha: 1)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(message:Message) {
        label.text = message.message
        messageBubble.backgroundColor = message.senderType == "user" ? .Bronze_900 : .Bronze_500
        leftImage.isHidden = message.senderType == "user"
    }
    
    
    
}
extension UIView{
 
    func roundCorners( radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner]
        }
    func circleButton(radius:CGFloat)  {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner]
    }
   }
