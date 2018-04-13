//
//  BuddyTable.swift
//  Group Connection
//
//  Created by BURRIGHT, NICHOLAS on 3/19/18.
//  Copyright © 2018 District196. All rights reserved.
//
import UIKit

class BuddyTable: UITableViewCell {

    @IBOutlet weak var buddyName: UILabel!
    @IBOutlet weak var statusPic: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.lightGray

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
