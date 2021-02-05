//
//  HistoryRouter.swift
//  BankApp
//
//  Created by User on 1/31/21.
//

import UIKit

final class HistoryRouter: BaseRouter {
    init(_ name:String) {
        let view = HistoryViewController(nibName: "HistoryViewController", bundle: nil)
        super.init(viewController: view)
        let interactor: HistoryPresenterToInteractorProtocol = HistoryInteractor()
        let router:HistoryPresenterToRouterProtocol = self
        let presenter: HistoryViewToPresenterProtocol & HistoryInteractorToPresenterProtocol = HistoryPresenter(router: router, view: view , interactor: interactor,name: name)
        view.presenter = presenter
        interactor.presenter = presenter
    }

}

//MARK:- Home Presenter To Router Protocol
extension HistoryRouter: HistoryPresenterToRouterProtocol {
    func dissmissView() {
        navigationController?.popRouter()
    }
}
