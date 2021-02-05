//
//  HistoryInterator.swift
//  BankApp
//
//  Created by User on 31/01/21.
//

import Foundation

class HistoryInteractor: HistoryPresenterToInteractorProtocol {
    fileprivate var coreDataHandler  = CoreDataHandler.sharedInstance
    var presenter: HistoryInteractorToPresenterProtocol?
    
    //MARK:- Get History details
    /* To get all transaction history details for the user
     * Parameters :
            name     : Name of the logged in user
     */
    
    func getHistoryDetails(name: String) {
        let historyData:[History] = coreDataHandler.getAllDatasWithPredicate(entity: "History", predicate: NSPredicate(format: "name ==  %@ || payee == %@", name.lowercased().capitalized, name.lowercased().capitalized), sortDescriptor: NSSortDescriptor(key: "date", ascending: true)) as? [History] ?? []
        presenter?.historyDetailsCompletedWithSuccess(data: historyData)
    }
}
