//
//  BuddyRosterView.swift
//  Group Connection
//
//  Created by BURRIGHT, NICHOLAS on 3/22/18.
//  Copyright © 2018 District196. All rights reserved.
//

import UIKit
import SnapKit

class BuddyRosterView: Sub, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var titleBar: UILabel!
    @IBOutlet weak var scroller: UIScrollView! //the superview for the table
    
    var data: [Person] = Globals.globals.teamRoster.filter({(person: Person) -> Bool in
        if Globals.globals.user.buddyList.contains(person) || person == Globals.globals.user{
            return false
        }
        return true
    })
    var filterD: [Person]! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        table.sectionIndexColor = .none
        searchBar.delegate = self
        table.dataSource = self
        filterD = data
                
        constrain()
        
        if Globals.globals.user.buddyList.count > 2 {
            titleBar.text = "You got too many buddies. Please press back and "
        }
    }
    
    // tells how many cells you want to have in the roster. This will be the number of people at the competition
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterD.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("buddy roster cell has been clicked")
         Globals.globals.user.buddyList.insert(Globals.globals.teamRoster[indexPath.row], at: 0)
        
        if Globals.globals.user.buddyList.count >= 4 {
            print("if is running")
            Globals.globals.user.buddyList.remove(at: 3)

        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
        
        print(Globals.globals.user.buddyList[0].fullName)
//        dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "backToCheckIn", sender: nil)
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
    
    private func constrain() {
        searchBar.snp.makeConstraints { (snap) -> Void in
            snap.top.equalTo(titleBar.snp.bottomMargin)
//            snap.bottom.equalTo(table.snp.topMargin)
//            snap.centerX.equalTo(self.view.snp.centerX)
            snap.leading.equalTo(10)
            snap.trailing.equalTo(-10)
        }

        print(scroller.center)
        print(table.center)
        
        scroller.snp.makeConstraints { (snap) -> Void in
            print("constraining scroller")
//            snap.top.equalTo(searchBar.snp.bottomMargin)
//            snap.leading.equalTo(10)
//            snap.trailing.equalTo(-10)
//            snap.centerX.equalTo(view.snp.centerX)
            snap.center.equalTo(view.snp.center)
        }

        print(scroller.center)
        print(table.center)
        
        table.snp.makeConstraints { (snap) -> Void in
//            snap.leading.equalTo(10)
            print("constraining table")
            snap.trailing.equalTo(10)

//            snap.top.equalTo(searchBar.snp.bottomMargin)
//            snap.centerX.equalTo(self.view.snp.centerX)
//            snap.bottom.equalTo(self.view.snp.bottomMargin)
        }
        
        print(scroller.center)
        print(table.center)

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

