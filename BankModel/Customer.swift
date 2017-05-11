//
//  Customer.swift
//  BankModel
//
//  Created by Alisher Abdukarimov on 4/17/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import Foundation


class Customer: Person {
    //Hash
    let email: String
    
    override var hashValue: Int {
        return email.hashValue
    }
    
    static func ==(lhs: Customer, rhs: Customer) -> Bool {
        return lhs.email == rhs.email
    }
    
    init?(givenName: String, familyName: String, email: String) {
        guard email.isEmpty == false else{
            return nil
        }
        self.email = email
        super.init(givenName: givenName, familyName: familyName)
    }
    
    
}


extension Customer {
    
    convenience init?(jsonObject: [String:Any]) {
        guard let givenName = jsonObject[Customer.nameKey] as? String,
            let familyName = jsonObject[Customer.familyNameKey] as? String,
            let email = jsonObject[Customer.emailKey] as? String
            else {
                return nil
        }
        self.init(givenName: givenName,
                  familyName: familyName,
                  email: email)
        
    }
    
    var jsonObject: [String:Any] {
        
        let back: [String:Any] = [
            Customer.nameKey:givenName,
            Customer.familyNameKey:familyName,
            Customer.emailKey:email
        ]
        return back
    }
    
    internal static var nameKey: String = "givenName"
    internal static var familyNameKey: String = "familyName"
    internal static var emailKey: String = "email"
}
