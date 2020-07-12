//
//  TableViewController.swift
//  ExamApp1
//
//  Created by Vladislav McKay on 7/11/20.
//  Copyright © 2020 Vladislav McKay. All rights reserved.
//

import UIKit
import Foundation


class TableViewController: UITableViewController {
    
    
    // -Data-
    
    
    
    let tableViewRefreshControl: UIRefreshControl = UIRefreshControl()

    var urlSession: URLSession!
    
    @IBOutlet weak var genderSortSegmentedControl: UISegmentedControl!
    
    @IBAction func genderSortSegmentedControlSwitch() {
        if genderSortSegmentedControl.selectedSegmentIndex == 0 {
            malesOnly = persons.filter{$0.gender == "Male"}
            femalesOnly.removeAll()
        } else if genderSortSegmentedControl.selectedSegmentIndex == 1 {
            femalesOnly = persons.filter{$0.gender == "Female"}
            malesOnly.removeAll()
        } else if genderSortSegmentedControl.selectedSegmentIndex == 2 {
            malesOnly.removeAll()
            femalesOnly.removeAll()

        }
                    tableView.reloadData()
    }
    
    @IBAction func rearrange() {
        
        if malesOnly.count > 0 {
            if malesOnly[0].age <= malesOnly[1].age {
                malesOnly = malesOnly.sorted(by: {$0.age > $1.age})
 
            } else if malesOnly[0].age >= malesOnly[1].age {
                malesOnly = malesOnly.sorted(by: {$0.age < $1.age})
             }
        } else if femalesOnly.count > 0 {
            if femalesOnly[0].age >= femalesOnly[1].age {
                femalesOnly = femalesOnly.sorted(by: {$0.age < $1.age})
             } else if femalesOnly[0].age <= femalesOnly[1].age {
                femalesOnly = femalesOnly.sorted(by: {$0.age > $1.age})
              }
        } else {
        
        if persons[0].age <= persons[1].age {
            persons = persons.sorted(by: { $0.age > $1.age })
         }
            
        else if persons[0].age >= persons[1].age {
            persons = persons.sorted(by: {$0.age < $1.age})
         }
        }
        tableView.reloadData()
    }
    
    // overrided methods
    
    @objc func handleRefresh()
    {
        persons.removeAll()
        malesOnly.removeAll()
        femalesOnly.removeAll()
        takeDataFromURL(requestURL!)
        
        genderSortSegmentedControl.selectedSegmentIndex = 2
        
        tableViewRefreshControl.endRefreshing()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = self.tableViewRefreshControl
        let myString = "Pull to refresh"
        let myAttribute = [NSAttributedString.Key.foregroundColor: UIColor.systemTeal]
        let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
        refreshControl!.attributedTitle = myAttrString
        refreshControl!.addTarget(self, action: #selector(self.handleRefresh), for: UIControl.Event.valueChanged)
        genderSortSegmentedControl.selectedSegmentIndex = 2
        takeDataFromURL(requestURL!)
        //rearrangeButton.titleLabel!.text = "aa"
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
        
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        urlSession = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
        
        
    }
    
    
    // MARK: - Table view data source
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !malesOnly.isEmpty {
            return malesOnly.count
        } else if !femalesOnly.isEmpty {
            return femalesOnly.count
        } else {
            return persons.count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Some people"
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.textColor = .white
        cell.textLabel?.highlightedTextColor = .lightGray
        
        
        cell.textLabel?.textAlignment = .center
        
        if !malesOnly.isEmpty && genderSortSegmentedControl.selectedSegmentIndex == 0 {
            cell.textLabel!.text = "\(malesOnly[indexPath.row].firstName),   \(malesOnly[indexPath.row].age), \(malesOnly[indexPath.row].gender)"
        } else if !femalesOnly.isEmpty && genderSortSegmentedControl.selectedSegmentIndex == 1 {
            cell.textLabel!.text = "\(femalesOnly[indexPath.row].firstName),   \(femalesOnly[indexPath.row].age), \(femalesOnly[indexPath.row].gender)"
        } else {
            cell.textLabel!.text = "\(persons[indexPath.row].firstName),   \(persons[indexPath.row].age), \(persons[indexPath.row].gender)"
        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndexPathRow = indexPath.row
        let vcToPop = storyboard?.instantiateViewController(identifier: "PersonInfoPopUpViewController")
        vcToPop?.modalPresentationStyle = .popover
        show(vcToPop!, sender: self)
        if vcToPop!.isViewLoaded {
            tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
        }
        
    }
    
    
 
    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            persons.remove(at: indexPath.row)
//
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
    
    
    
    // Override to support rearranging the table view.
//    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//
//    }
//
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
     func takeDataFromURL(_ url: URL) {
        
       
        let task = urlSession.dataTask(with: url) {
            
            (data, response, error) in
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSMutableArray
                if let error = error {
                    print("\(error.localizedDescription)")
                }
                var jsonDict: [String:Any] = [:]
                
                
                for singlePersonFromRequest in json {
                    
                    
                    jsonDict =  singlePersonFromRequest as! [String : Any]
                    
                    
                    persons.append(Person.init(age: jsonDict["age"] as! Int, firstName: jsonDict["first_name"] as! String, lastName: jsonDict["last_name"] as! String, email: jsonDict["email"] as! String, gender: jsonDict["gender"] as! String, ipAddress: jsonDict["ip_address"] as! String))
                    malesOnly = malesOnly.sorted(by: {$0.age > $1.age})
                    femalesOnly = femalesOnly.sorted(by: {$0.age > $1.age})

                    
                }
                self.tableView.reloadData()
                
                
            } catch let jsonError {
                print(jsonError)
            }
        }
        task.resume()
        tableView.reloadData()
    }
}
