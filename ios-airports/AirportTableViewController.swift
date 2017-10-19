//
//  AirportTableViewController.swift
//  ios-airports
//
//  Created by Robin Post on 16/10/2017.
//  Copyright © 2017 Robin Post. All rights reserved.
//

import UIKit

class AirportTableViewController: UITableViewController {
    
    var airports : [Airport] = []
    var airportDictionary: Dictionary<String, Array<String>> = [:]
    var airportSections = [String]()
    var database = DatabaseHelper.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        airports = database.read()
        generateWordsDict()
        self.tableView.reloadData()
    }
    
    func generateWordsDict() {
        for airport in airports {
            let ident = "\(airport.ident!)"
            let key = String(ident.first!) // first letter of the name is the key
            if var arrayForLetter = airportDictionary[key] { // if the key already exists
                arrayForLetter.append(airport.ident!) // we update the value
                airportDictionary.updateValue(arrayForLetter, forKey: key) // and we pass it to the dictionary
            } else { // if the key doesn't already exists in our dictionary
                airportDictionary.updateValue([airport.ident!], forKey: key) // we create an array with the name and add it to the dictionary
            }
        }
        airportSections = [String](airportDictionary.keys)
        airportSections = airportSections.sorted()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return airportDictionary.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let contactKey = airportSections[section]
        if let contactValue = airportDictionary[contactKey]{
            return contactValue.count
        }
        return 0
    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return airports.count
//    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return airportSections
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "airportIdentifier", for: indexPath) as! AirportTableViewCell
        
        let airportKey = airportSections[indexPath.section]
        
        if let airportValue = airportDictionary[airportKey] {
            cell.labelName?.text = airportValue[indexPath.row]
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.airportSections[section].uppercased()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }

}
