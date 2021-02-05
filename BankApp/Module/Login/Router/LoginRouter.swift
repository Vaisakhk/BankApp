//
//  LoginRouter.swift
//  BankApp
//
//  Created by User on 31/01/21.
//

import UIKit

final class LoginRouter: BaseRouter {
    init() {
        let view = UIStoryboard(name:"Main",bundle: Bundle.main).instantiateViewController(withIdentifier: "viewController") as! ViewController
        super.init(viewController: view)
        let interactor: LoginPresenterToInteractorProtocol = LoginInteractor()
        let router:LoginPresenterToRouterProtocol = self
        let presenter: LoginViewToPresenterProtocol & LoginInteractorToPresenterProtocol = LoginPresenter(router: router, view: view, interactor: interactor)
      
        view.presenter = presenter
        interactor.presenter = presenter
    }
    
    //MARK:- Navigate to Friends list
    private func navigateToHomeScreen(name:String) {
        let controller = HomeRouter(name)
        viewController.presentRouter(controller, presentationStyle: .fullScreen)
    }
}

//MARK:- Login Presenter To Router Protocol
extension LoginRouter: LoginPresenterToRouterProtocol {
    func pushToHomeScreen(userName:String) {
        navigateToHomeScreen(name: userName)
    }
}
