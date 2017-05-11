//
//  CustomerTest.swift
//  BankModel
//
//  Created by Alisher Abdukarimov on 5/3/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import XCTest
@testable import BankModel

class CustomerTest: XCTestCase {
    
    
    func testMarthaStewart() {
        let result = Customer(givenName: "Martha", familyName: "Stewart", email: "martha@stewart.com")!
        XCTAssertEqual(result.givenName, "Martha")
        XCTAssertEqual(result.familyName, "Stewart")
        XCTAssertEqual(result.email, "martha@stewart.com")
    }
    
    
    func testSerializeToJSON() {
        let expectedFamily = "Stewart"
        let expectedGiven = "Martha"
        let expectedEmail = "martha@stewart.com"
        
        let customer = Customer(givenName: expectedGiven,
                                familyName: expectedFamily,
                                email: expectedEmail)!
        let result = customer.jsonObject
        
        
        if let resultEmail = result[Customer.emailKey] as? String,
            let resultFamily = result[Customer.familyNameKey] as? String,
            let resultGiven = result[Customer.nameKey] as? String {
            XCTAssertEqual(resultEmail, expectedEmail)
            XCTAssertEqual(resultGiven, expectedGiven)
            XCTAssertEqual(resultFamily, expectedFamily)
        } else {
            XCTFail("failed to extract value(s) for JSON Keys")
        }
    }
    func testSerializeToJSON2() {
        let expectedFamily = "Ali"
        let expectedGiven = "Abdukarimov"
        let expectedEmail = "UniversalTenantOrganization@stewart.com"
        
        let customer = Customer(givenName: expectedGiven,
                                familyName: expectedFamily,
                                email: expectedEmail)!
        let result = customer.jsonObject
        
        
        if let resultEmail = result[Customer.emailKey] as? String,
            let resultFamily = result[Customer.familyNameKey] as? String,
            let resultGiven = result[Customer.nameKey] as? String {
            XCTAssertEqual(resultEmail, expectedEmail)
            XCTAssertEqual(resultGiven, expectedGiven)
            XCTAssertEqual(resultFamily, expectedFamily)
        } else {
            XCTFail("failed to extract value(s) for JSON Keys")
        }
    }
    
    
    
    func testSerializeToJSONEmployee() {
        let expectedFamily = "Ali"
        let expectedGiven = "Abdukarimov"
        let expectedPhone = "9177247666"
        
        let employee = Employee(givenName: expectedGiven, familyName: expectedFamily, telephoneNumber: expectedPhone)!
        let result = employee.jsonObject
        
        if let resultPhoneNumber = result[Employee.telephoneNumberKey] as? String,
           let resultGivenName = result[Employee.nameKey] as? String,
           let resultFamilyName = result[Employee.familyNameKey] as? String {
        
            XCTAssertEqual(resultPhoneNumber, expectedPhone)
            XCTAssertEqual(resultGivenName, expectedGiven)
            XCTAssertEqual(resultFamilyName, expectedFamily)
        } else {
            XCTFail("failed to extract value(s) for JSON Keys")
        }
       
        
        
        
        
    }

    
    
    
}
