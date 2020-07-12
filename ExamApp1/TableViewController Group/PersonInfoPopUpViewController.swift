//
//  PersonInfoPopUpViewController.swift
//  ExamApp1
//
//  Created by Vladislav McKay on 7/11/20.
//  Copyright © 2020 Vladislav McKay. All rights reserved.
//

import Foundation
import UIKit

class PersonInfoPopUpViewController: UIViewController {
    // Data
    var ageLabel: UILabel = UILabel()
    var firstNameLabel: UILabel = UILabel()
    var lastNameLabel: UILabel = UILabel()
    var emailLabel: UILabel = UILabel()
    var genderLabel: UILabel = UILabel()
    var ipAddressLabel: UILabel = UILabel()
    
    var footerLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = nil
        makeLabelsLookGood([footerLabel, ageLabel, firstNameLabel, lastNameLabel, emailLabel, genderLabel, ipAddressLabel])
        
        setUpSubViews()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        giveLabelsText()
        setUpSubViews()
        
    }
    
    private func setUpSubViews() {
        
        view.backgroundColor = UIColor(cgColor: CGColor(srgbRed: 100/255, green: 195/255, blue: 255/255, alpha: 0.95))
        view.addSubview(footerLabel)
        footerLabel.translatesAutoresizingMaskIntoConstraints = false
        footerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        footerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        footerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        footerLabel.heightAnchor.constraint(equalToConstant: 120).isActive = true
        footerLabel.font = .boldSystemFont(ofSize: 25)
        
        
        view.addSubview(ageLabel)
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        ageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        ageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        ageLabel.topAnchor.constraint(equalTo: footerLabel.bottomAnchor, constant: 8).isActive = true
        ageLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(firstNameLabel)
        firstNameLabel.translatesAutoresizingMaskIntoConstraints = false
        firstNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        firstNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        firstNameLabel.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 8).isActive = true
        firstNameLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(lastNameLabel)
        lastNameLabel.translatesAutoresizingMaskIntoConstraints = false
        lastNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        lastNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        lastNameLabel.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 8).isActive = true
        lastNameLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(emailLabel)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        emailLabel.topAnchor.constraint(equalTo: lastNameLabel.bottomAnchor, constant: 8).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(genderLabel)
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        genderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        genderLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8).isActive = true
        genderLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(ipAddressLabel)
        ipAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        ipAddressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        ipAddressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        ipAddressLabel.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 8).isActive = true
        ipAddressLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        
    }
    
    func giveLabelsText() {
        footerLabel.isHidden = false
        ageLabel.isHidden = false
        firstNameLabel.isHidden = false
        lastNameLabel.isHidden = false
        emailLabel.isHidden = false
        genderLabel.isHidden = false
        ipAddressLabel.isHidden = false
        
        footerLabel.text = "FULL INFO"
        if malesOnly.count > 0 {
            ageLabel.text = "Age: \(malesOnly[currentIndexPathRow].age)"
            firstNameLabel.text = malesOnly[currentIndexPathRow].firstName
            lastNameLabel.text = malesOnly[currentIndexPathRow].lastName
            emailLabel.text = malesOnly[currentIndexPathRow].email
            genderLabel.text = malesOnly[currentIndexPathRow].gender
            ipAddressLabel.text = "IP Address: \(malesOnly[currentIndexPathRow].ipAddress)"}
        else if femalesOnly.count > 0 {
            ageLabel.text = "Age: \(femalesOnly[currentIndexPathRow].age)"
            firstNameLabel.text = femalesOnly[currentIndexPathRow].firstName
            lastNameLabel.text = femalesOnly[currentIndexPathRow].lastName
            emailLabel.text = femalesOnly[currentIndexPathRow].email
            genderLabel.text = femalesOnly[currentIndexPathRow].gender
            ipAddressLabel.text = "IP Address: \(femalesOnly[currentIndexPathRow].ipAddress)"
        }
        else {
        ageLabel.text = "Age: \(persons[currentIndexPathRow].age)"
        firstNameLabel.text = persons[currentIndexPathRow].firstName
        lastNameLabel.text = persons[currentIndexPathRow].lastName
        emailLabel.text = persons[currentIndexPathRow].email
        genderLabel.text = persons[currentIndexPathRow].gender
        ipAddressLabel.text = "IP Address: \(persons[currentIndexPathRow].ipAddress)"
        }
        
    }
    
    func makeLabelsLookGood(_ labelsToMakeLookGood: [UILabel]) {
        for label in labelsToMakeLookGood {
            label.textColor = .white
            label.textAlignment = .center
            label.font = .boldSystemFont(ofSize: 20)
            label.layer.cornerRadius = 8
            label.layer.backgroundColor = CGColor(srgbRed: 100/255, green: 175/255, blue: 255/255, alpha: 0.95)
        }
    }
    
}


