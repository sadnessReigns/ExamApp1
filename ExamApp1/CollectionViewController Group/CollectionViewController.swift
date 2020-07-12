//
//  CollectionViewController.swift
//  ExamApp1
//
//  Created by Vladislav McKay on 7/11/20.
//  Copyright © 2020 Vladislav McKay. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var genderSortSegmentedControl: UISegmentedControl!
    @IBOutlet var collectionView: UICollectionView!
    var urlSession: URLSession!
    
//    var tvc: TableViewController = TableViewController()
//    var requestURL: URL!
    var collectionViewRefreshControl: UIRefreshControl = UIRefreshControl()
    var currentIndexPathForItem: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        genderSortSegmentedControl.selectedSegmentIndex = 2
        
        self.collectionViewRefreshControl = UIRefreshControl()
        self.collectionView!.alwaysBounceVertical = true
        
        let myString = "Pull to refresh"
        let myAttribute = [NSAttributedString.Key.foregroundColor: UIColor.systemTeal]
        let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
        collectionViewRefreshControl.attributedTitle = myAttrString
        collectionViewRefreshControl.addTarget(self, action: #selector(self.handleRefresh), for: UIControl.Event.valueChanged)
        self.collectionView!.addSubview(collectionViewRefreshControl)
        
        collectionView.allowsSelection = true
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        //   self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        // Do any additional setup after loading the view.
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        urlSession = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
    }
    
    @IBAction func rearrangeButtonTapped(sender: Any) {
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
        collectionView.reloadData()
    }
    
    @IBAction func genderSortSegmentedControlSwitch(sender: UISegmentedControl) {
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
        collectionView.reloadData()
    }
    
    @objc func handleRefresh() {
        persons.removeAll()
        malesOnly.removeAll()
        femalesOnly.removeAll()
        takeDataFromURL(requestURL!)
        
        genderSortSegmentedControl.selectedSegmentIndex = 2
        
        
        self.collectionViewRefreshControl.endRefreshing()
    }
    
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
                self.collectionView.reloadData()
                
                
            } catch let jsonError {
                print(jsonError)
            }
        }
        task.resume()
        collectionView.reloadData()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        if !malesOnly.isEmpty {
            return malesOnly.count
        } else if !femalesOnly.isEmpty {
            return femalesOnly.count
        } else {
            return persons.count
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! MyCollectionViewCell
        
        cell.backgroundColor = .systemTeal
        cell.layer.cornerRadius = 8
        cell.heightAnchor.constraint(equalToConstant: 128).isActive = true
        cell.widthAnchor.constraint(equalToConstant: 128).isActive = true
        
        cell.myLabel.textColor = .white
        cell.myLabel.font = .boldSystemFont(ofSize: 20)
        cell.myLabel.textAlignment = .center
        cell.myLabel.highlightedTextColor = .lightGray
        cell.myLabel.numberOfLines = 0
        if !malesOnly.isEmpty && genderSortSegmentedControl.selectedSegmentIndex == 0 {
            cell.myLabel!.text = "\(malesOnly[indexPath.row].firstName)\n\(malesOnly[indexPath.row].age)\n\(malesOnly[indexPath.row].gender)"
        } else if !femalesOnly.isEmpty && genderSortSegmentedControl.selectedSegmentIndex == 1 {
            cell.myLabel!.text = "\(femalesOnly[indexPath.row].firstName)\n\(femalesOnly[indexPath.row].age)\n\(femalesOnly[indexPath.row].gender)"
        } else {
            cell.myLabel!.text = "\(persons[indexPath.row].firstName)\n\(persons[indexPath.row].age)\n\(persons[indexPath.row].gender)"
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentIndexPathRow = indexPath.row
        let vcToPop = storyboard?.instantiateViewController(identifier: "PersonInfoPopUpViewController")
        vcToPop?.modalPresentationStyle = .popover
        show(vcToPop!, sender: self)
        
        if vcToPop!.isViewLoaded {
            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
