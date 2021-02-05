//
//  HomeProtocol.swift
//  BankApp
//
//  Created by User on 31/01/21.
//

import UIKit

protocol HomeViewToPresenterProtocol: BasePresenterProtocal{
    func logoutUser()
    func topUpAmount(amount:String)
    func payAmount(to payeeName:String,amount:String)
    var loggedInUser: String? {get}
    func showHistory()
}

protocol HomePresenterToViewProtocol: BaseViewProtocol{
    func refreshUI(message:String)
}

protocol HomePresenterToRouterProtocol: RouterProtocal {
    func dissmissView()
    func pushToHistoryScreen(userName:String)
}

protocol HomePresenterToInteractorProtocol: BaseInteractorProtocol {
    var presenter:HomeInteractorToPresenterProtocol? {get set}
    func getAmountValue(name:String)
    func topUpAmount(with amountValue:String,username:String)
    func insertPayAmount(from userName:String,to payeeName:String,amount:String)
}

protocol HomeInteractorToPresenterProtocol: BaseInteractorToPresenterProtocol {
    func balanceAmountCompletedWithSuccess(data:Double)
    func topUPCompletedWithError(errorString:String)
}
