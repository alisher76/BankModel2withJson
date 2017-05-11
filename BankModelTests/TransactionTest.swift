//
//  TransactionTest.swift
//  BankModel
//
//  Created by Alisher Abdukarimov on 5/2/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import XCTest
@testable import BankModel

class TransactionTests: XCTestCase {
    func testTransactionDebitAmountForDebit() {
        let transaction = Account.Transaction(amount: -100.00,
                                              userDescription: "food",
                                              vendor: "Publix",
                                              datePosted: nil)
        
        let result = transaction.debitAmount
        let expected = 100.00
        XCTAssertEqual(result, expected)
    }
    
    func testTransactionDebitAmountForCredit() {
        let transaction = Account.Transaction(amount: 100.00,
                                              userDescription: "refund for Fyre Festival",
                                              vendor: "Ja Rule",
                                              datePosted: nil)
        
        let result = transaction.debitAmount
        let expected = -100.00
        XCTAssertEqual(result, expected)
    }
    
    func testTransactionDebitAmountForCredit2() {
        let transaction = Account.Transaction(amount: 5000.00,
                                              userDescription: "refund for Fyre Festival",
                                              vendor: "Ja Rule",
                                              datePosted: nil)
        
        let result = transaction.debitAmount
        let expected = -5000.00
        XCTAssertEqual(result, expected)
    }
    
    func testWithdrawal() {
        guard let account = CheckingsAccount(deposit: 100.00) else {
            XCTFail("failed to create account with initial deposit")
            return
        }
        XCTAssertEqual(account.balance, 100)
        let success = account.withdraw(amount: 75)
        XCTAssertTrue(success)
        XCTAssertEqual(account.balance, 25)
    }
    
    
    func testFailedWithdrawal() {
        guard let account = CheckingsAccount(deposit: 100.00) else {
            XCTFail("failed to create account with initial deposit")
            return
        }
        XCTAssertEqual(account.balance, 100)
        let success = account.withdraw(amount: 1000)
        XCTAssertFalse(success)
        XCTAssertEqual(account.balance, 100)
    }
    
    
    func testDeposit() {
        guard let account = CheckingsAccount(deposit: 100.00) else {
            XCTFail("failed to create account with initial deposit")
            return
        }
        XCTAssertEqual(account.balance, 100)
        let success = account.depositMoney(amount: 10)
        XCTAssertTrue(success)
        XCTAssertEqual(account.balance, 110)
    }
    
    
    func testDeposit2() {
        guard let account = CheckingsAccount(deposit: 100.00) else {
            XCTFail("failed to create account with initial deposit")
            return
        }
        XCTAssertEqual(account.balance, 100)
        let success = account.depositMoney(amount: 1000)
        XCTAssertTrue(success)
        XCTAssertEqual(account.balance, 1100)
    }
    
    func testTransactionHistory() {
        
        let bank = Bank(address: "777", accountsDirectory: [:], employee: [])
        let customer = Customer(givenName: "Ali", familyName: "Abd", email: "@")
        let newAccount = CheckingsAccount()
        let newTransaction = Account.Transaction(amount: 100, userDescription: "Rent", vendor: "Bank", datePosted: Date())
        let newTransaction2 = Account.Transaction(amount: 200, userDescription: "Rent", vendor: "Bank", datePosted: Date())
        let newTransaction3 = Account.Transaction(amount: 200, userDescription: "Rent", vendor: "Bank", datePosted: Date())
        newAccount.transactions.append(newTransaction)
        newAccount.transactions.append(newTransaction2)
        newAccount.transactions.append(newTransaction3)
        bank.addAccount(account: newAccount, customer: customer!)
        
        let result = bank.getListOfTransactions(customer: customer!, uuid: newAccount.id)!
        let expected: [Account.Transaction] = [newTransaction, newTransaction2, newTransaction3]
        var outcome = false
        if expected.count == result.count {
        outcome = true
        }else{
        outcome = false
        }
        XCTAssertTrue(outcome)
    }
    
    func testFailTransactionHistory() {
        
        let bank = Bank(address: "777", accountsDirectory: [:], employee: [])
        let customer = Customer(givenName: "Ali", familyName: "Abd", email: "@")
        let newAccount = CheckingsAccount()
        let newTransaction = Account.Transaction(amount: 100, userDescription: "Rent", vendor: "Bank", datePosted: Date())
        let newTransaction2 = Account.Transaction(amount: 200, userDescription: "Rent", vendor: "Bank", datePosted: Date())
        let newTransaction3 = Account.Transaction(amount: 200, userDescription: "Rent", vendor: "Bank", datePosted: Date())
        newAccount.transactions.append(newTransaction)
        newAccount.transactions.append(newTransaction2)
        bank.addAccount(account: newAccount, customer: customer!)
        
        let result = bank.getListOfTransactions(customer: customer!, uuid: newAccount.id)!
        let expected: [Account.Transaction] = [newTransaction, newTransaction2, newTransaction3]
        var outcome = false
        if expected.count == result.count {
            outcome = true
        }else{
            outcome = false
        }
        XCTAssertFalse(outcome)
    }
}











