//
//  CheckingsAccount.swift
//  BankModel
//
//  Created by Alisher Abdukarimov on 5/2/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import Foundation


class CheckingsAccount: Account {
    
    override var accountType: Account.AccountType{
        return .checking
 }
}
