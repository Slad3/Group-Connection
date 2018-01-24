//
//  RosterView.swift
//  Group Connection
//
//  Created by BARCASKEY, BENJAMIN on 12/14/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

class RosterView: UIViewController {
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // tells how many cells you want to have in the roster. This will be the number of people at the competition
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //not yet updated to do the real profiles.
        
        return globals.teamRoster.count
    }
    
    
    // tells what should be displayed in each cell.
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //test this here---------------
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = globals.teamRoster[indexPath.row].fullName
        
        return cell
        
    }
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
