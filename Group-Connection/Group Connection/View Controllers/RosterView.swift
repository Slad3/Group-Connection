//
//  RosterView.swift
//  Group Connection
//
//  Created by BARCASKEY, BENJAMIN on 12/14/17.
//  Copyright © 2017 District196. All rights reserved.
//

import UIKit

class RosterView: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table: UITableView!
    
    var data: [Person] = Globals.globals.teamRoster
    var filterD: [Person]! = nil
    
    // this is the Roll call Button. It will set the timers for everyone to false
    @IBAction public func rollCall(_ sender: Any) {
       print("Roll Call")
        
        //sets the check in status for everyone to false
        for i in 0...Globals.globals.teamRoster.count - 1 {
            Globals.globals.teamRoster[i].checkInStatus = false
            //send alert to everyone to check in
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        table.sectionIndexColor = .none
        searchBar.delegate = self
        table.dataSource = self
        filterD = data
        
        //delete everything below here eventually
        Globals.globals.autopopulateRoster()
        data = Globals.globals.teamRoster
        filterD = data
        table.reloadData()
    }
    
    // tells how many cells you want to have in the roster. This will be the number of people at the competition
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return filterD.count }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        Globals.globals.selectedIndex = indexPath.row
        
        if Globals.globals.selectedIndex == indexPath.row {
            tableView.deselectRow(at: indexPath, animated: true)
            performSegue(withIdentifier: "toRosterProfileVC", sender: nil )
        }
        else {
            dismiss(animated: false, completion: nil)
        }
    }
        
    
    // tells what should be displayed in each cell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //test this here
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RosterViewCellTableViewCell
        cell.fullName.text = filterD[indexPath.row].fullName
        
        if filterD[indexPath.row].checkInStatus {
            cell.status.text = "Checked In"
        }
        else {
            cell.status.text = "Not checked in"
        }
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterD = searchText.isEmpty ? data : data.filter { (item: Person) -> Bool in
            // if dataItem matches the searchText, return true to include it
            return item.fullName.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        table.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //lower any keyboards when the user taps anywhere besides a text box
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

