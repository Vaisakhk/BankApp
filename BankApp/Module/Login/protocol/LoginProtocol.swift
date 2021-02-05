//
//  LoginProtocol.swift
//  BankApp
//
//  Created by User on 31/01/21.
//

import UIKit

protocol LoginViewToPresenterProtocol: BasePresenterProtocal{
    var currentKeyWord: String? { get set }
}

protocol LoginPresenterToViewProtocol: BaseViewProtocol{

}

protocol LoginPresenterToRouterProtocol: RouterProtocal {
    func pushToHomeScreen(userName:String)
}

protocol LoginPresenterToInteractorProtocol: BaseInteractorProtocol {
    var presenter:LoginInteractorToPresenterProtocol? {get set}
}

protocol LoginInteractorToPresenterProtocol: BaseInteractorToPresenterProtocol {

}
