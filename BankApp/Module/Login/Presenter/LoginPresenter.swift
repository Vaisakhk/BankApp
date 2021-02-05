//
//  LoginPresenter.swift
//  BankApp
//
//  Created by Created by User on 31/01/21.
//

import UIKit

class LoginPresenter: LoginViewToPresenterProtocol {
    
    private var _view: LoginPresenterToViewProtocol?
    private var _interactor: LoginPresenterToInteractorProtocol?
    private var _router: LoginPresenterToRouterProtocol?
    
    var currentKeyWord: String? {
        didSet {
            if(currentKeyWord?.count != 0) {
                didMovetoHomeScreen()
            }else {
                _router?.showAlertPopup(with: AlertConstants.enterNamePlaceHolder, title: AlertConstants.alertTitle, successButtonTitle: AlertConstants.closeButtonTitle)
            }
        }
    }
    
    //MARK:- Initialization
    init(router: LoginPresenterToRouterProtocol, view: LoginPresenterToViewProtocol, interactor: LoginPresenterToInteractorProtocol) {
        _view = view
        _router = router
        _interactor = interactor
    }
    
    //MARK:- Route to Home Screen
    func didMovetoHomeScreen() {
        _router?.pushToHomeScreen(userName: currentKeyWord ?? "")
    }
}

//MARK:- Interactor to presenter Protocols
extension LoginPresenter : LoginInteractorToPresenterProtocol {
    
}
