//
//  CatCell.swift
//  Mazadaat
//
//  Created by macbook on 11/13/20.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

class CatCell: UITableViewCell {

    @IBOutlet weak var backV: UIView!
    @IBOutlet weak var tagV: DesignableView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var loction: UILabel!
    @IBOutlet weak var auctionNumberTimes: UILabel!
    @IBOutlet weak var auctionNumber: UILabel!
    @IBOutlet weak var auctionName: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    

        // Initialization code
    }
    
    func configeData(obj: AuctionsOB){
        var mianImg = ""
        
        if let img = obj.mediaArry?.first?.file{
            mianImg = img
        }
        
        tagV.roundCorners([.layerMinXMinYCorner, .layerMinXMaxYCorner], radius: 7)
            img.roundCorners([.layerMaxXMinYCorner, .layerMinXMinYCorner], radius: 10)
        img.sd_setImage(with: mianImg.toURL, completed: nil)
        auctionName.text = obj.name ?? ""
        lblPrice.text = "\(obj.LastBid?.price ?? "") ر.س"
        auctionNumber.text = "#\(obj.code ?? "")"
        lblTimer.text = obj.start_at ?? ""
        auctionNumberTimes.text = "\(obj.bids_count ?? 0) مزايدة"

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
