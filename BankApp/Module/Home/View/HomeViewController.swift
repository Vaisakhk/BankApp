//
//  HomeViewController.swift
//  BankApp
//
//  Created by User on 31/01/21.
//

import UIKit

class HomeViewController: UIViewController {
    var presenter:HomeViewToPresenterProtocol?
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var payeeAmountTextField: UITextField!
    @IBOutlet weak var payeeNameTextField: UITextField!
    @IBOutlet weak var topUpamountTextField: UITextField!

    
    //MARK:- UIView Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
        customizeUI()
    }
    
    //MARK:- UIView Customization
    func customizeUI() {
        title =  presenter?.loggedInUser

        addRightBarButtonCustom()
        addLeftBarButtonCustom()
    }
    
    func addRightBarButtonCustom() {
        let barButton = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(self.backButtonaction))
        self.navigationItem.leftBarButtonItem = barButton
    }

    func addLeftBarButtonCustom() {
        let barButton = UIBarButtonItem(title: "History", style: .done, target: self, action: #selector(self.leftButtonaction))
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    //MARK:- UIView Action
    @objc func backButtonaction() {
        presenter?.logoutUser()
    }
    
    @objc func leftButtonaction() {
        presenter?.showHistory()
    }
    
    @IBAction func topUpButtonAction(_ sender: Any) {
        self.view.endEditing(true)
        presenter?.topUpAmount(amount:topUpamountTextField.text ?? "")
    }
    
    @IBAction func payButtonAction(_ sender: Any) {
        self.view.endEditing(true)
        presenter?.payAmount(to: payeeNameTextField.text ?? "", amount: payeeAmountTextField.text ?? "")
    }
}

//MARK:- Home Presenter To view Protocol
extension HomeViewController : HomePresenterToViewProtocol {
    func refreshUI(message:String) {
        welcomeLabel.text = message
        topUpamountTextField.text = ""
        payeeNameTextField.text = ""
        payeeAmountTextField.text = ""
    }
    
}

extension HomeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == payeeAmountTextField || textField == topUpamountTextField) {
            let tempArray:[String] = (textField.text?.components(separatedBy: "."))!
            if(tempArray.count >= 2) {
                if( string == ".") {
                    return false
                }
                if(!string.validateAmount()) {
                    return false
                }
            }else if(!string.validateAmount()) {
                return false
            }
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension String {
    func validateAmount() -> Bool {
        let emailReges:String = " 0123456789.";
        let characterSet:CharacterSet = NSCharacterSet(charactersIn: emailReges).inverted as CharacterSet
        let filtered = self.components(separatedBy: characterSet ).joined(separator: "")
        return self == filtered
    }
}
