//
//  HistoryProtocol.swift
//  BankApp
//
//  Created by User on 31/01/21.
//

import Foundation

import UIKit

protocol HistoryViewToPresenterProtocol: BasePresenterProtocal{
    var historyList: [History]? { get }
    func goBacktToHome()
    var loggedInUser: String? {get}
}

protocol HistoryPresenterToViewProtocol: BaseViewProtocol{
    func refreshUI()
}

protocol HistoryPresenterToRouterProtocol: RouterProtocal {
    func dissmissView()
}

protocol HistoryPresenterToInteractorProtocol: BaseInteractorProtocol {
    var presenter:HistoryInteractorToPresenterProtocol? {get set}
    func getHistoryDetails(name:String)
}

protocol HistoryInteractorToPresenterProtocol: BaseInteractorToPresenterProtocol {
    func historyDetailsCompletedWithSuccess(data:[History])
    func historyDetailsWithError(errorString:String)
}
