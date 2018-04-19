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
        self.backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.backgroundColor = UIColor.clear
        // Configure the view for the selected state
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.backgroundColor = UIColor.purple
    }
}
