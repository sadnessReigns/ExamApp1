//
//  GlobalVariables.swift
//  ExamApp1
//
//  Created by Vladislav McKay on 7/11/20.
//  Copyright © 2020 Vladislav McKay. All rights reserved.
//

import Foundation


struct Person {
    var age: Int
    var firstName: String
    var lastName: String
    var email: String
    var gender: String
    var ipAddress: String
}

let requestURL = URL(string: "https://my.api.mockaroo.com/persons.json?key=22321320")


var persons: [Person] = []
var malesOnly: [Person] = []
var femalesOnly: [Person] = []

var currentIndexPathRow: Int = -1
