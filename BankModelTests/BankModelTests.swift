//
//  BankModelTests.swift
//  BankModelTests
//
//  Created by Alisher Abdukarimov on 4/14/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import XCTest
@testable import BankModel

class BankModelTests: XCTestCase {
    
    
    func testAddCustomer() {
        let bank = Bank(address: "777", accountsDirectory: [:], employee: [])
        let customer = Customer(givenName: "Ali", familyName: "Abd", email: "@")
        let result = bank.addAccount(account: CheckingsAccount.init(transactions: [], id: UUID()), customer: customer!)
        XCTAssertTrue(result! == true)

    
    }
       
    func testWithdraw(){
    
        
        let account = CheckingsAccount(deposit: 101)
        let success = account?.withdraw(amount: 75)
        XCTAssertTrue(success!)
        XCTAssertTrue(account?.balance == 26)
    
    }

    
    func testWithdrawFail(){
        
    
        let account = CheckingsAccount(deposit: 100.00)
        let success = account?.withdraw(amount: 20)
        XCTAssertTrue(success!)
        XCTAssertTrue(account?.balance == 80)
        
    }

    func testWithdrawUUID2(){
        let uuID = UUID()
        
        let account = CheckingsAccount(deposit: 100.00, id: uuID)
        print("this is a ID \(uuID)")
        let success = account?.withdraw(amount: 20)
        XCTAssertTrue(success!)
        XCTAssertTrue(account?.balance == 80)
        
    }

    
    func testDeposit(){
        
        let account = CheckingsAccount(deposit: 0.01, id: UUID())
        let success = account?.depositMoney(amount: 100)
        XCTAssertTrue(success!)
        XCTAssertTrue(account?.balance == 100.01)
        
    }

    

    func testCheckAllCashInCustomersAccounts() {
        let account:Set<Account> = [CheckingsAccount(deposit: 30.50)!]
        let customer = Customer(givenName: "Ali", familyName: "Abd", email: "@")
        let bank = Bank(address: "777", accountsDirectory: [customer!:account], employee: [])
        let result = bank.totalSumOfTheCustomersCashInAllAccounts(customer: customer!)
        let expected = 30.50
        XCTAssertEqual(result, expected)
    }

    
    func testTotalNumberOfAccountsInTheBank() {
        let account:Set<Account> = [CheckingsAccount(deposit: 30.50)!, SavingsAccount(deposit: 30.50)!]
        let customer = Customer(givenName: "Ali", familyName: "Abd", email: "@")
        let bank = Bank(address: "777", accountsDirectory: [customer!:account], employee: [])
        let result = bank.totalNumberOfAllAccountsInTheBank()
        let expected = 2
        XCTAssertEqual(result, expected)
    }

    func testTotalNumberOfAccountsInTheBank2() {
        let account: Account = CheckingsAccount(deposit: 30.50)!
        let account1:Account = CheckingsAccount(deposit: 30.50)!
        let account2: Account = SavingsAccount(deposit: 30.50)! //This Was CheckingsAccount The Whole Time 😡 and thats why my function was not counting third account F*&^
        let customer1 = Customer(givenName: "Alisher", familyName: "Abdukarimov", email: "@mail")
        let customer = Customer(givenName: "Ali", familyName: "Abd", email: "@")
        let bank = Bank(address: "777", accountsDirectory: [customer!: [account], customer1!: [account1, account2]], employee: [])
        let result = bank.totalNumberOfAllAccountsInTheBank()
        let expected = 3
        XCTAssertEqual(result, expected)
    }
    func testTotalamountOfCashInTheBank3() {
        let account3: Account = SavingsAccount(deposit: 30)!
        let account2: Account = SavingsAccount(deposit: 30)!
        let account: Account = CheckingsAccount(deposit: 30)!
        let account1: Account = CheckingsAccount(deposit: 30)!
        let customer1 = Customer(givenName: "Alisher", familyName: "Abdukarimov", email: "@mail")
        let customer = Customer(givenName: "Ali", familyName: "Abd", email: "@")
        let bank = Bank(address: "777", accountsDirectory: [customer!: [account,account2], customer1!: [account1,account3]], employee: [])
        let result = bank.totalSumOfBanksCash()
        let expected = 120.00
        XCTAssertEqual(result, expected)
    }

    func testTotalSumOfBanksCash() {
        let account2: Account = SavingsAccount(deposit: 30.50)!
        let account: Account = CheckingsAccount(deposit: 30.50)!
        let account1: Account = CheckingsAccount(deposit: 30.50)!
        let customer1 = Customer(givenName: "Alisher", familyName: "Abdukarimov", email: "@mail")
        let customer = Customer(givenName: "Ali", familyName: "Abd", email: "@")
        let bank = Bank(address: "777", accountsDirectory: [customer!: [account], customer1!: [account1,account2]], employee: [])
        let result = bank.totalSumOfBanksCash()
        let expected = 91.50
        XCTAssertEqual(result, expected)
    
    }
    
    
    func testBankSerialization() {
        let newBank = Bank(address: "777", accountsDirectory: [:], employee: [])
        let customer = Customer(givenName: "Ali", familyName: "Abu", email: "@")
        let employee = Employee(givenName: "Sam", familyName: "Darl", telephoneNumber: "828282")
        let addCustomer = newBank.addAccount(account: CheckingsAccount.init(transactions: [], id: UUID()), customer: customer!)
        newBank.addNewEmployee(newEmployee: employee!)
        
        let result = newBank.jsonObject
        print("did it happen or what ---- - - -- - - \(result.description)")
        // Its Wokring
    }
    
    
}
