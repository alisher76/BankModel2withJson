//
//  BankModel.swift
//  BankModel
//
//  Created by Alisher Abdukarimov on 4/15/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import Foundation

class Bank: Equatable {
    
    typealias AccountsDirectory = [Customer:Set<Account>]
    
    var accountsDirectory: AccountsDirectory
    var employee: Set<Employee>
    let address: String
    
    init(address: String,accountsDirectory: AccountsDirectory, employee: Set<Employee>) {
        self.accountsDirectory = accountsDirectory
        self.employee = employee
        self.address = address
    }
    
    static func ==(lhs: Bank, rhs: Bank) ->Bool {
        return lhs.accountsDirectory == rhs.accountsDirectory && lhs.employee == rhs.employee && lhs.address == rhs.address
    }
    
    var customers: Set<Customer> {
        return Set(accountsDirectory.keys)
    }
    
    var accounts: Set<Account> {
        return Set(accountsDirectory.values.flatMap{ $0 })
    }
    
    var balance: Double {
        return accounts.reduce(0) {
            $0 + $1.balance
        }
    }
    
    func addCustomer(customer: Customer) -> Bool {
        if accountsDirectory.keys.contains(customer) {
            return false
        }else{
            accountsDirectory[customer] = []
            return true
        }
    }
    
    
    func addAccount(account: Account, customer: Customer) -> Bool? {
        
        if var customerAccounts = accountsDirectory[customer],
            customerAccounts.contains(account) == false {
            customerAccounts.insert(account)
            accountsDirectory[customer] = customerAccounts
            return true
        }else if accountsDirectory[customer] == nil {
            accountsDirectory[customer] = [account]
            return true
        }else{
            return false
        }
    }
    
    
    func addNewEmployee(newEmployee: Employee) -> Bool {
        
        employee.insert(newEmployee)
        
        return true
        
    }
    
    func withdrawMoneyFromSpecificAccount(amount: Double, from account: Account) -> Bool {
        
        if amount > account.balance {
            return false
        }else{
            return account.withdraw(amount: amount)        }
    }
    
    func depositToSpecificAccount(amount: Double, from account: Account) -> Bool {
        return account.depositMoney(amount: amount)
    }
    
    
    
    func getCustomerAccounts(customer: Customer, optionalAccountType: Account.AccountType? = nil) -> Set<Account>?
    {
        
        guard let customerAccounts = accountsDirectory[customer] else {
            return nil
        }
        guard let accountType = optionalAccountType else {
            return customerAccounts
        }
        
        let filteredArray = customerAccounts.filter{ $0.accountType == accountType
            
        }
        
        
        return Set(filteredArray)
    }
    
    func totalSumOfTheCustomersCashInAllAccounts(customer: Customer) -> Double? {
        
        guard let customerAccounts = accountsDirectory[customer] else {
            return nil
        }
        let totalBalance = customerAccounts.map{ $0.balance }.reduce(0.0, { x, y in x + y })
        
        return totalBalance
    }
    
    func getListOfTransactions(customer: Customer, uuid: UUID) -> [Account.Transaction]? {
        var listOftransactions: [Account.Transaction] = []
        guard let customerAccounts = accountsDirectory[customer] else {
            return nil
        }
        
        for account in customerAccounts {
            if account.id == uuid {
                listOftransactions = account.transactions
            }
        }
        return listOftransactions
    }
    
    
    
    func totalNumberOfAllAccountsInTheBank() -> Int {
        let flattenedAccounts = accountsDirectory.values.flatMap{ $0 }.count
        return flattenedAccounts
        
    }
    
    func totalSumOfBanksCash() -> Double? {
        
        var total = 0.0
        
        let flattenedAccounts = accountsDirectory.flatMap{ key, value in
            return value
        }
        
        for i in flattenedAccounts {
            total += i.balance
        }
        
        return total
    }
    
    
    
}

extension Bank {
    
    convenience init?(jsonObject: [String:Any]) {
        guard let address = jsonObject[Bank.addressKey] as? String,
            let employee = jsonObject[Bank.employeeKey] as? Set<Employee>,
            let accountsDirectory = jsonObject[Bank.accountDirectoryKey] as? [Customer:Set<Account>]
            else {
                return nil
        }
        
        self.init(address: address, accountsDirectory: accountsDirectory, employee: employee)
    }
    
    
    var jsonObject: [String:Any] {
        let back: [String:Any] = [
            Bank.addressKey: address,
            Bank.employeeKey: employee,
            Bank.accountDirectoryKey: accountsDirectory
        ]
        return back
    }
    
    internal static var addressKey: String = "address"
    internal static var employeeKey: String = "employee"
    internal static var accountDirectoryKey: String = "accountsDirectory"
}

