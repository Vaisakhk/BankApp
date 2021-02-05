//
//  HomeInteractor.swift
//  BankApp
//
//  Created by User on 31/01/21.
//

import Foundation
import UIKit

class HomeInteractor: HomePresenterToInteractorProtocol {
    
    
    fileprivate var coreDataHandler  = CoreDataHandler.sharedInstance
    var presenter: HomeInteractorToPresenterProtocol?
    
    //MARK:- Inser topup data
    /* Insert Top up amount Data
            Assuming User name is unique
            After updating the TOp up amount for the user it will update back to the UI
     * Parameters :
            amountValue  : Amount value
            username     : Name of the logged in user
     */
    func topUpAmount(with amountValue:String,username:String) {
        if(amountValue.count == 0) {
            presenter?.topUPCompletedWithError(errorString: AlertConstants.topUpEmptyMessage)
        }else {
            increaseBalanceAmount(for: username, amount: (Double(amountValue) ?? 0.0))
            saveHistoryData(name: username, amount: Double(amountValue) ?? 0.0, payee: "",type: "Top up")
            getAmountValue(name: username)
        }
    }
    
    //MARK:- Get Amount for logged in user
    /* Get Balance amount for logged in user
     * Parameters :
            username     : Name of the logged in user
     */
    func getAmountValue(name:String){
        var amount = 0.0
        let userData:[User] = coreDataHandler.getAllDatasWithPredicate(entity: "User", predicate: NSPredicate(format: "(name ==  %@)", name.lowercased().capitalized), sortDescriptor: NSSortDescriptor(key: "name", ascending: true)) as? [User] ?? []
        if let user = userData.first {
            amount = user.balance
        }
        presenter?.balanceAmountCompletedWithSuccess(data: amount)
    }
    
    //MARK:- Insert amount for payee
    /* Insert amount for payee and save the record in history
            For the logged in user reduce the balance
            For the pay increase the total balance
     * Parameters :
            username     : Name of the logged in user
            payeeName    : Name of the payee
            amount       : Amount want to transfer to payee
     */
    func insertPayAmount(from userName:String,to payeeName:String,amount:String) {
        let userData:[User] = coreDataHandler.getAllDatasWithPredicate(entity: "User", predicate: NSPredicate(format: "(name ==  %@)", userName.lowercased().capitalized), sortDescriptor: NSSortDescriptor(key: "name", ascending: true)) as? [User] ?? []
        var user = userData.first
        if (user == nil) {
            user  = coreDataHandler.newEntityForName(entityName: "User") as? User
        }
        user?.name = userName.lowercased().capitalized
        let tempAmountValue = (user?.balance ?? 0.0) - (Double(amount) ?? 0.0)
        user?.balance = tempAmountValue
        coreDataHandler.saveContext()
        saveHistoryData(name: userName, amount: Double(amount) ?? 0.0, payee: payeeName, type: "Pay Now")
        increaseBalanceAmount(for: payeeName, amount: (Double(amount) ?? 0.0))
        presenter?.balanceAmountCompletedWithSuccess(data: tempAmountValue)
    }
    
    
    //MARK:- Increase Balance Amount
    /* Increace balance amount for payee
     * Parameters :
            name         : Name of the payee
            amount       : Amount want to transfer to payee
     */
    private func increaseBalanceAmount(for name:String, amount:Double){
        let userData:[User] = coreDataHandler.getAllDatasWithPredicate(entity: "User", predicate: NSPredicate(format: "(name ==  %@)", name.lowercased().capitalized), sortDescriptor: NSSortDescriptor(key: "name", ascending: true)) as? [User] ?? []
        var user = userData.first
        if (user == nil) {
            user  = coreDataHandler.newEntityForName(entityName: "User") as? User
        }
        user?.name = name.lowercased().capitalized
        let tempAmountValue = (user?.balance ?? 0.0) + Double(amount)
        user?.balance = tempAmountValue
        coreDataHandler.saveContext()
    }
    
    //MARK:- Save record in History
    /* Save all the transaction in history table view
     * Parameters :
            name         : Name of the logged in user
            amount       : Amount want to transfer to payee
            payee        : Name of the payee
            type         : Type of transaction "Pay Now" or "Top up"
     */
    
    private func saveHistoryData(name:String, amount:Double, payee:String, type:String = "") {
        let history  = coreDataHandler.newEntityForName(entityName: "History") as? History
        history?.name = name.lowercased().capitalized
        history?.amount =  Double(amount)
        history?.type = type
        history?.payee = payee.lowercased().capitalized
        history?.date = getDate()
        coreDataHandler.saveContext()
    }
    
    /* TO Get current Date string
     * return :
            string      : Returns current date in dd/MM/yyyy hh:mm:ss format
     */
    private func getDate() -> String {
        let dateFormatter:DateFormatter = DateFormatter ()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        dateFormatter.calendar = NSCalendar(calendarIdentifier: .gregorian)! as Calendar
        return dateFormatter.string(from: Date())
    }
}
