//
//  HistoryPresenter.swift
//  BankApp
//
//  Created by User on 31/01/21.
//

import Foundation

class HistoryPresenter: HistoryViewToPresenterProtocol {
    private var _view: HistoryPresenterToViewProtocol?
    private var _interactor: HistoryPresenterToInteractorProtocol?
    private var _router: HistoryPresenterToRouterProtocol?
    
    var historyList: [History]? {
        didSet {
            _view?.refreshUI()
        }
    }
    
    var loggedInUser: String? {
        didSet {
          
        }
    }
    //MARK:- Initialization
    init(router: HistoryPresenterToRouterProtocol, view: HistoryPresenterToViewProtocol, interactor: HistoryPresenterToInteractorProtocol,name:String) {
        _view = view
        _router = router
        _interactor = interactor
        loggedInUser = name
    }
    
    func viewDidLoad() {
        _interactor?.getHistoryDetails(name: loggedInUser ?? "")
    }
    
    //MARK:- Router Navigation
    func goBacktToHome() {
        
    }
    
}

//MARK:- Interactor to presenter Protocols
extension HistoryPresenter : HistoryInteractorToPresenterProtocol {
    func historyDetailsCompletedWithSuccess(data: [History]) {
        historyList = data
    }
    
    func historyDetailsWithError(errorString: String) {
        _router?.showAlertPopup(with: errorString,title: AlertConstants.alertTitle, successButtonTitle: AlertConstants.closeButtonTitle)
    }
    
}
