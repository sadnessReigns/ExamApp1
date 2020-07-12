//
//  ModelController.swift
//  ExamApp1
//
//  Created by Vladislav McKay on 7/12/20.
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

class ModelController {
    var peopleToReturn: [Person] = []
    var currentPerson: Person?
    let requestURL = URL(string: "https://my.api.mockaroo.com/people.json?key=e1e89470")
    
    func getPeople (urlSession: URLSession, completion: @escaping (() -> ()))  {
        peopleToReturn.removeAll()
        let task = urlSession.dataTask(with: requestURL!) {
            
            (data, response, error) in
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSMutableArray
                if let error = error {
                    print("\(error.localizedDescription)")
                }
                var jsonDict: [String:Any] = [:]
                
                
                for singlePersonFromRequest in json {
                    
                    jsonDict =  singlePersonFromRequest as! [String : Any]
                    
                    self.peopleToReturn.append(Person.init(age: jsonDict["age"] as! Int, firstName: jsonDict["first_name"] as! String, lastName: jsonDict["last_name"] as! String, email: jsonDict["email"] as! String, gender: jsonDict["gender"] as! String, ipAddress: jsonDict["ip_address"] as! String))
                    
                }
                completion()
                
                
            } catch let jsonError {
                print(jsonError)
            }
            
        }
        
        task.resume()
        
        
    }
    
    func getAll() -> [Person] {
        return peopleToReturn.filter{ $0.gender == "Male" || $0.gender == "Female" }
    }
    
    func getMale() -> [Person] {
        return peopleToReturn.filter { $0.gender == "Male" }
        
    }
    
    func getFemale() -> [Person] {
        return peopleToReturn.filter { $0.gender == "Female" }
        
    }
}
