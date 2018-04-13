//
//  BuddyRosterView.swift
//  Group Connection
//
//  Created by BURRIGHT, NICHOLAS on 3/22/18.
//  Copyright © 2018 District196. All rights reserved.
//

import UIKit

class BuddyRosterView: Sub, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table: UITableView!
    
    var data: [Person] = Globals.globals.teamRoster
    var filterD: [Person]! = nil
    
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
    
    override func viewDidAppear(_ animated: Bool) {
//         table.reloadData()
    }
    
    // tells how many cells you want to have in the roster. This will be the number of people at the competition
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return filterD.count }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("buddy roster cell has been clicked")
        
      //  Globals.globals.user.buddyList.append(Globals.globals.teamRoster[indexPath.row])
         Globals.globals.user.buddyList.insert(Globals.globals.teamRoster[indexPath.row], at: 0)
        if Globals.globals.user.buddyList.count >= 4
        {
            print("if is running")
            Globals.globals.user.buddyList.remove(at: 3)

        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
        
        print(Globals.globals.user.buddyList[0].fullName)
        performSegue(withIdentifier: "backToCheckIn", sender: nil)
        print("Back to check in")
        
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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

