//
//  Person.swift
//  BankModel
//
//  Created by Alisher Abdukarimov on 4/15/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import Foundation


class Person : CustomStringConvertible, Hashable{
    
    let givenName: String
    let familyName: String
    
    var fullName: String {
        return "\(givenName) \(familyName)"
    }
    
    var hashValue: Int{
        return fullName.hashValue
    }
    
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.fullName == rhs.fullName
    }
    
    var description: String {
        return "(name: \(fullName))"
    }
    
    init?(givenName: String, familyName: String) {
        guard givenName.isEmpty == false,
            familyName.isEmpty == false else {
                return nil
        }
        self.givenName = givenName
        self.familyName = familyName
    }
    
    
    
}
