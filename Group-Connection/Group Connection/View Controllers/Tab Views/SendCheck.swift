//
//  CheckView.swift
//  Group Connection
//
//  Created by NARANJO, DANIEL on 4/12/18.
//  Copyright © 2018 District196. All rights reserved.
//

import Foundation
import UIKit

class SendCheck: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var locationSwitch: UISwitch!
    @IBOutlet weak var messageBox: UITextView!
    
    var data: [Person] = Globals.globals.user.buddyList
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.sectionIndexColor = .cyan
        table.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BuddyTable
    }
}
