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
    
    var currentPeople: [Person] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    let mc = (UIApplication.shared.delegate as! AppDelegate).modelController
    
    @IBOutlet weak var genderSortSegmentedControl: UISegmentedControl!
    @IBOutlet var collectionView: UICollectionView!
    var urlSession: URLSession!
    
    
    var collectionViewRefreshControl: UIRefreshControl = UIRefreshControl()
    var currentIndexPathForItem: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mc.getPeople(urlSession: urlSession ) {
            self.currentPeople = self.mc.getAll()
        }
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
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        urlSession = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
    }
    
    @IBAction func rearrangeButtonTapped(sender: Any) {
        
        if currentPeople[0].age <= currentPeople[1].age {
            currentPeople = currentPeople.sorted(by: { $0.age > $1.age })
            
        }
            
        else if currentPeople[0].age >= currentPeople[1].age {
            currentPeople = currentPeople.sorted(by: {$0.age < $1.age})
            
        }
        collectionView.reloadData()
    }
    
    @IBAction func genderSortSegmentedControlSwitch(sender: UISegmentedControl) {
        if genderSortSegmentedControl.selectedSegmentIndex == 0 {
            
            currentPeople = mc.getMale()
        } else if genderSortSegmentedControl.selectedSegmentIndex == 1 {
            
            currentPeople = mc.getFemale()
        } else if genderSortSegmentedControl.selectedSegmentIndex == 2 {
            
            currentPeople = mc.getAll()
        }
        collectionView.reloadData()
    }
    
    @objc func handleRefresh() {
        currentPeople.removeAll()
        
        mc.getPeople(urlSession: urlSession ) {
            self.currentPeople = self.mc.getAll()
        }
        genderSortSegmentedControl.selectedSegmentIndex = 2
        self.collectionView.reloadData()
        
        self.collectionViewRefreshControl.endRefreshing()
    }
    
    // MARK: UICollectionViewDataSource
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return currentPeople.count
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
        
        cell.myLabel!.text = "\(currentPeople[indexPath.row].firstName)\n\(currentPeople[indexPath.row].age)\n\(currentPeople[indexPath.row].gender)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        mc.currentPerson = currentPeople[indexPath.row]
        let vcToPop = storyboard?.instantiateViewController(identifier: "PersonInfoPopUpViewController")
        vcToPop?.modalPresentationStyle = .popover
        show(vcToPop!, sender: self)
        
        if vcToPop!.isViewLoaded {
            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }
    
}
