//
//  HomeRouter.swift
//  BankApp
//
//  Created by User on 31/01/21.
//

import UIKit

final class HomeRouter: BaseRouter {
    init(_ userName:String) {
        let view = HomeViewController(nibName: "HomeViewController", bundle: nil)
        super.init(viewController: UINavigationController(rootViewController: view))
        let interactor: HomePresenterToInteractorProtocol = HomeInteractor()
        let router:HomePresenterToRouterProtocol = self
        let presenter: HomeViewToPresenterProtocol & HomeInteractorToPresenterProtocol = HomePresenter(router: router, view: view , interactor: interactor,name: userName)
        view.presenter = presenter
        interactor.presenter = presenter
    }

    //MARK:- Navigate to Detail
    private func navigateToDetail(name:String) {
        let controller = HistoryRouter(name)
        navigationController?.pushRouter(controller, animated: true)
    }
}

//MARK:- Home Presenter To Router Protocol
extension HomeRouter: HomePresenterToRouterProtocol {

    func dissmissView() {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func pushToHistoryScreen(userName:String) {
        navigateToDetail(name:userName)
    }
    
}
