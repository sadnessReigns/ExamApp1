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
    
    let mc =  (UIApplication.shared.delegate as! AppDelegate).modelController
    
    
    
    var currentPeople: [Person] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    
    
    let tableViewRefreshControl: UIRefreshControl = UIRefreshControl()
    
    var urlSession: URLSession!
    
    @IBOutlet weak var genderSortSegmentedControl: UISegmentedControl!
    
    @IBAction func genderSortSegmentedControlSwitch() {
        
        if genderSortSegmentedControl.selectedSegmentIndex == 0 {
            
            currentPeople = mc.getMale()
        } else if genderSortSegmentedControl.selectedSegmentIndex == 1 {
            
            currentPeople = mc.getFemale()
        } else if genderSortSegmentedControl.selectedSegmentIndex == 2 {
            
            currentPeople = mc.getAll()
        }
    }
    
    @IBAction func rearrange() {
        
        
        if currentPeople[0].age <= currentPeople[1].age {
            currentPeople = currentPeople.sorted(by: { $0.age > $1.age })
        }
            
        else if currentPeople[0].age >= currentPeople[1].age {
            currentPeople = currentPeople.sorted(by: {$0.age < $1.age})
        }
        
    }
    
    
    @objc func handleRefresh()
    {
        
        mc.getPeople(urlSession: urlSession ) {
            self.currentPeople = self.mc.getAll()
        }
        
        
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
        
        
        mc.getPeople(urlSession: urlSession ) {
            self.currentPeople = self.mc.getAll()
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        urlSession = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
    }
    
    
    // MARK: - Table view data source
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return currentPeople.count
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Some people"
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.textColor = .white
        cell.textLabel?.highlightedTextColor = .lightGray
        
        
        cell.textLabel?.textAlignment = .center
        
        
        cell.textLabel!.text = "\(currentPeople[indexPath.row].firstName),   \(currentPeople[indexPath.row].age), \(currentPeople[indexPath.row].gender)"
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vcToPop = storyboard?.instantiateViewController(identifier: "PersonInfoPopUpViewController")
        mc.currentPerson = currentPeople[indexPath.row]
        vcToPop?.modalPresentationStyle = .popover
        show(vcToPop!, sender: self)
        if vcToPop!.isViewLoaded {
            tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
        }
        
    }
    
    
    
    
    
}
