//
//  BankAccount.swift
//  BankModel
//
//  Created by Alisher Abdukarimov on 4/17/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import Foundation


class Account {
    
    enum AccountType {
        case checking
        case savings
    }
    var id: UUID
    var transactions: [Transaction]
    
    var balance: Double {
        return transactions.reduce(0) { $0 + $1.amount }
    }
    
    init(transactions: [Transaction] = [], id: UUID = UUID()) {
        self.id = id
        self.transactions = transactions
        
    }
    
    convenience init?(deposit: Double, id: UUID = UUID()) {
        
        let initialTransaction: [Transaction]
        
        if deposit <= 0.0 {
            return nil
        }else{
            let firstTransaction = Transaction(amount: deposit, userDescription: nil, vendor: "Bank", datePosted: nil)
            initialTransaction = [firstTransaction]
        }
        self.init(transactions: initialTransaction, id: id)
        
    }
    
    
    var accountType: AccountType {
        fatalError("Unimplimented 'Account'. Use 'CheckingAccount or 'SavingsAccount'.")
    }
    
    func executeTransaction(transaction: Transaction, allowOverdrafts: Bool = false) -> Bool {
        switch transaction.transactionType {
        case .credit,
             .debit where allowOverdrafts ||  (balance >= transaction.debitAmount):
            transactions.append(transaction)
            return true
        case .debit:
            return false
            
        }
    }
    
    
    func withdraw(amount: Double) -> Bool{
        
        guard amount.sign == .plus, amount <= balance else {
            return false
        }
        let transaction = Transaction(amount: -amount, userDescription: "Cash withdraw", vendor: "Bank", datePosted: Date())
        transactions.append(transaction)
        return true
    }
    
    
    func depositMoney(amount: Double) -> Bool {
        let transaction = Transaction(amount: amount, userDescription: "Cash deposited", vendor: "Bank", datePosted: Date())
        transactions.append(transaction)
        return true
    }
    
    struct Transaction
    {
        enum TransactionType {
            /// Amount owed -100
            case debit
            /// Amount 100
            case credit
        }
        
        var amount: Double
        var userDescription: String?
        let vendor: String
        var datePosted: Date?
        let dateCreated: Date
        static func sanitize(date: Date) -> Date {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
            return calendar.date(from: components)!
        }
        
        public init(amount: Double,
                    userDescription: String?,
                    vendor: String,
                    datePosted: Date?) {
            self.init(amount: amount,
                      userDescription: userDescription,
                      vendor: vendor,
                      datePosted: datePosted,
                      dateCreated: Date())
        }
        internal init(amount: Double,
                      userDescription: String?,
                      vendor: String,
                      datePosted: Date?,
                      dateCreated: Date) {
            self.amount = amount
            self.userDescription = userDescription
            self.vendor = vendor
            self.datePosted = datePosted.map(Account.Transaction.sanitize(date:))
            self.dateCreated = Account.Transaction.sanitize(date: dateCreated)
        }
        
        
        
        var transactionType: TransactionType {
            if amount <= 0 {
                return .debit
            }else{
                return .credit
            }
        }
        
        var debitAmount: Double {
            return -amount
        }
        
        static func ==(_ lhs: Transaction, _ rhs: Transaction) -> Bool {
            return (lhs.amount == rhs.amount &&
                lhs.dateCreated == rhs.dateCreated &&
                lhs.datePosted == rhs.datePosted &&
                lhs.vendor == rhs.vendor &&
                lhs.userDescription == rhs.userDescription)
            
        }
    }
}

extension Account : Hashable {
    var hashValue: Int {
        return id.hashValue
    }
    
    static func ==(lhs: Account, rhs: Account) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Account {
    convenience init?(jsonObject: [String:Any]) {
        return nil
    }
    
    var jsonObject: [String:Any] {
        return [:]
    }
}

extension Account.Transaction {
    
    init?(jsonObject: [String:Any]) {
        guard let amount = jsonObject[Account.Transaction.amountKey] as? Double,
            let dateCreatedDouble = jsonObject[Account.Transaction.dateCreatedKey] as? Double,
            let vendor = jsonObject[Account.Transaction.vendorKey] as? String
            else {
                return nil
        }
        
        let dateCreated = Date(timeIntervalSince1970: dateCreatedDouble)
        let userDescription = jsonObject[Account.Transaction.userDescriptionKey] as? String
        
        let datePostedString = jsonObject[Account.Transaction.datePostedKey] as? String
        let datePosted = datePostedString.flatMap(Account.Transaction.dateFormatter.date(from:))
        self.init(amount: amount,
                  userDescription: userDescription,
                  vendor: vendor,
                  datePosted: datePosted,
                  dateCreated: dateCreated)
    }
    
    var jsonObject: [String:Any] {
        var back: [String:Any] = [
            Account.Transaction.amountKey : amount,
            Account.Transaction.dateCreatedKey: dateCreated.timeIntervalSince1970,
            Account.Transaction.datePostedKey : datePosted.map(Account.Transaction.dateFormatter.string(from:)) as Any,
            Account.Transaction.vendorKey: vendor,
            ]
        
        if let desc = userDescription {
            back[Account.Transaction.userDescriptionKey] = desc
        }
        
        return back
    }
    
    internal static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-DD'T'HH:mm:ssZ"
        let timeZoneName = TimeZone.abbreviationDictionary["UTC"]!
        let timeZone = TimeZone(identifier: timeZoneName)
        formatter.timeZone = timeZone
        return formatter
    }()
    
    internal static var amountKey: String = "amount"
    internal static var dateCreatedKey: String = "date_created"
    internal static var datePostedKey: String = "date_posted"
    internal static var vendorKey: String = "vendor"
    internal static var userDescriptionKey: String = "user_description"
}




