//
//  Constants.swift
//  BankApp
//
//  Created by User on 01/30/21.
//

import Foundation

struct UserDefaultKey {
    static let FIRSTTIME =  "FirstTime"
}

struct AlertConstants {
    static let yesButtonTitle = "YES"
    static let noButtonTitle = "NO"
    static let saveButtonTitle = "Save"
    static let closeButtonTitle = "Close"
    static let cancelButtonTitle = "Cancel"
    static let topUpButtonTitle = "Top up"
    static let payNowButtonTitle = "Pay Now"
    static let alertTitle = "Bank App"
    static let topUpMessage = "Do you want to top up for %@?"
    static let topUpEmptyMessage = "Please enter top up amount"
    static let topUpMaxMessage = "Entered amount is larger than the allowed transfer limit\n(Limit 999999999999999)"
    static let payNowToSameUserMessage = "Your are trying to send money to same account, can you please use top up feature?"
    static let payeeNameEmptyMessage = "Please enter Payee Name"
    static let payToEmptyMessage = "Please enter amount"
    static let payNowMessage = "Do you want to Pay %@ to %@?"
    
    static let enterNamePlaceHolder = "Please enter user name"
}

