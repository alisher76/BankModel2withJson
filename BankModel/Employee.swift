//
//  Employee.swift
//  BankModel
//
//  Created by Alisher Abdukarimov on 4/17/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//



class Employee: Person {
    //Hash
    let telephoneNumber: String
    
    override var hashValue: Int {
        return telephoneNumber.hashValue
    }
    
    static func ==(lhs: Employee, rhs: Employee) -> Bool {
        return lhs.telephoneNumber == rhs.telephoneNumber
    }
    
    
    init?(givenName: String, familyName: String, telephoneNumber: String) {
        self.telephoneNumber = telephoneNumber
        super.init(givenName: givenName, familyName: familyName)
    }
    
}

extension Employee {
    
    convenience init?(jsonObject: [String:Any]) {
        guard let givenName = jsonObject[Employee.nameKey] as? String,
            let familyName = jsonObject[Employee.familyNameKey] as? String,
            let telephoneNumber = jsonObject[Employee.telephoneNumberKey] as? String
            else {
                return nil
        }
        self.init(givenName: givenName,
                  familyName: familyName,
                  telephoneNumber: telephoneNumber)
        
    }
    
    var jsonObject: [String:Any] {
        
        let back: [String:Any] = [
            Employee.nameKey:givenName,
            Employee.familyNameKey:familyName,
            Employee.telephoneNumberKey:telephoneNumber
        ]
        return back
    }
    
    internal static var nameKey: String = "givenName"
    internal static var familyNameKey: String = "familyName"
    internal static var telephoneNumberKey: String = "telephoneNumber"
}
