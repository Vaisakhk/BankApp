//
//  HomePresenter.swift
//  BankApp
//
//  Created by User on 31/01/21.
//

import UIKit
import Foundation

class HomePresenter: HomeViewToPresenterProtocol {
    
    private var _view: HomePresenterToViewProtocol?
    private var _interactor: HomePresenterToInteractorProtocol?
    private var _router: HomePresenterToRouterProtocol?
    
    var loggedInUser: String? {
        didSet {
          
        }
    }
    
    //MARK:- Initialization
    init(router: HomePresenterToRouterProtocol, view: HomePresenterToViewProtocol, interactor: HomePresenterToInteractorProtocol,name:String) {
        _view = view
        _router = router
        _interactor = interactor
        loggedInUser = name
    }
    
    //MARK:- View Didload will fire from controller view didload
    func viewDidLoad() {
        _interactor?.getAmountValue(name: loggedInUser ?? "")
    }
    
    //MARK:- Called when view will appear called from controller
    func viewWillAppear(animated: Bool) {

    }
    
    //MARK:- Top up Amount
    /* Start Top up amount to logged in user
     * Parameters :
            amount       : Amount want to top up to logged in user
     */
    func topUpAmount(amount: String) {
        if(amount.count == 0) {
            _router?.showAlertPopup(with: AlertConstants.topUpEmptyMessage,title: AlertConstants.alertTitle, successButtonTitle: AlertConstants.closeButtonTitle)
        }else if(amount.count > 15) {
            _router?.showAlertPopup(with: AlertConstants.topUpMaxMessage,title: AlertConstants.alertTitle, successButtonTitle: AlertConstants.closeButtonTitle)
        }else {
            let message = String(format: AlertConstants.topUpMessage, amount)
            
            _router?.showAlertWithButtons(alertMessage:message,title:AlertConstants.alertTitle,successButtonTitle:AlertConstants.topUpButtonTitle,cancelButtonTitle:AlertConstants.cancelButtonTitle,successBlock: { [weak self] (isSuccess) in
                if let weakSelf = self , isSuccess {
                    weakSelf._interactor?.topUpAmount(with: amount, username: weakSelf.loggedInUser ?? "")
                }
            })
        }
    }
    
    //MARK:- Pay Amount to payee
    /* Start pay now option
     * Parameters :
            payeeName    : Payee name to whom logged in user need to transfer
            amount       : Amount want to top up to logged in user
     */
    func payAmount(to payeeName:String,amount:String) {
        if(payeeName.count == 0) {
            _router?.showAlertPopup(with: AlertConstants.payeeNameEmptyMessage,title: AlertConstants.alertTitle, successButtonTitle: AlertConstants.closeButtonTitle)
        }else if(amount.count == 0) {
            _router?.showAlertPopup(with: AlertConstants.payToEmptyMessage,title: AlertConstants.alertTitle, successButtonTitle: AlertConstants.closeButtonTitle)
        }else if(amount.count > 15) {
            _router?.showAlertPopup(with: AlertConstants.topUpMaxMessage,title: AlertConstants.alertTitle, successButtonTitle: AlertConstants.closeButtonTitle)
        }else if(payeeName.lowercased().capitalized == loggedInUser ?? "") {
            _router?.showAlertPopup(with: AlertConstants.payNowToSameUserMessage,title: AlertConstants.alertTitle, successButtonTitle: AlertConstants.closeButtonTitle)
        }else {
            let message = String(format: AlertConstants.payNowMessage, amount,payeeName)
            
            _router?.showAlertWithButtons(alertMessage:message,title:AlertConstants.alertTitle,successButtonTitle:AlertConstants.payNowButtonTitle,cancelButtonTitle:AlertConstants.cancelButtonTitle,successBlock: { [weak self] (isSuccess) in
                if let weakSelf = self , isSuccess {
                    weakSelf._interactor?.insertPayAmount(from: weakSelf.loggedInUser ?? "", to: payeeName, amount: amount)
                }
            })
            
        }
    }
    
    //MARK:- Router Navigation
    /*
     *To show History screen
     */
    func showHistory() {
        _router?.pushToHistoryScreen(userName: loggedInUser ?? "")
    }
    
    /*
     *To Logout the user
     */
    func logoutUser() {
        _router?.dissmissView()
        loggedInUser = ""
    }
}

//MARK:- Interactor to presenter Protocols
extension HomePresenter : HomeInteractorToPresenterProtocol {
    func balanceAmountCompletedWithSuccess(data:Double) {
        _view?.refreshUI(message: "Hello, " + (loggedInUser ?? "") + "!\n" + "Your Balance is \(data)" )
    }
    
    func topUPCompletedWithError(errorString: String) {
        _router?.showAlertPopup(with: errorString,title: AlertConstants.alertTitle, successButtonTitle: AlertConstants.closeButtonTitle)
    }
}
