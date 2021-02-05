//
//  ViewController.swift
//  BankApp
//
// Created by User on 31/01/21.
//

import UIKit

class ViewController: UIViewController {
    var presenter:LoginViewToPresenterProtocol?
    @IBOutlet weak var userNameTextField: UITextField!
    
    //MARK:- UIView Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- UIView Action
    @IBAction func loginButtonAction(_ sender: Any) {
        presenter?.currentKeyWord = userNameTextField.text?.lowercased().capitalized
        userNameTextField.text = ""
    }
}

//MARK:- Home Presenter To view Protocol
extension ViewController : LoginPresenterToViewProtocol {
    
}
