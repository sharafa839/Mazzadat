//
//  AuctionSpecificationView.swift
//  Mazadaat
//
//  Created by Sharaf on 24/04/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

class AuctionSpecificationView: UIView, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    var auctionDetails:[AuctionDetail]?
    var descriptions:String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        containerView.setRoundCorners(10)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AuctionSpcificationTableViewCell.nib, forCellReuseIdentifier: AuctionSpcificationTableViewCell.identifier)
        tableView.register(AuctionSpecificationHeader.nib, forCellReuseIdentifier: AuctionSpecificationHeader.identifier)
    }
    
    func configure(_ with:[AuctionDetail],description:String) {
        auctionDetails = with
        self.descriptions = description
         tableView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadSelfFromNib()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        auctionDetails?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AuctionSpcificationTableViewCell = tableView.dequeue()
        guard let item = auctionDetails?[indexPath.row] else {return UITableViewCell()}
        cell.configure(auction: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell:AuctionSpecificationHeader = tableView.dequeue()
        cell.configure(with: descriptions ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        auctionDetails?.count ?? 0 == 0 ? 140:100
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "descriptionsr"
    }

}
