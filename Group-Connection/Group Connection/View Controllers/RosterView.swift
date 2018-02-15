//
//  RosterView.swift
//  Group Connection
//
//  Created by BARCASKEY, BENJAMIN on 12/14/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

class RosterView: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    // this is the Roll call Button. It will set the timers for everyone to false
    @IBAction public func rollCall(_ sender: Any) {
       print("Roll Call")
        
        
        //sets the check in status for everyone to false
        for index in 0...Globals.globals.teamRoster.count - 1
        {
            Globals.globals.teamRoster[index].checkInStatus = false
        
        }
        // now people need to check in to make their pictures change
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // tells how many cells you want to have in the roster. This will be the number of people at the competition
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //not yet updated to do the real profiles.
        
        return Globals.globals.teamRoster.count
    }
    
    
    // tells what should be displayed in each cell.
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //test this here---------------
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RosterViewCellTableViewCell
        
        cell.fullName.text = Globals.globals.teamRoster[indexPath.row].fullName
        
        return cell
        
    }
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
