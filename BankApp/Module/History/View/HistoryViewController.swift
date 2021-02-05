//
//  HistoryViewController.swift
//  BankApp
//
//  Created by User on 31/01/21.
//

import UIKit

class HistoryViewController: UIViewController {
    var presenter:HistoryViewToPresenterProtocol?
    
    @IBOutlet weak var tableView: UITableView!
    //MARK:- UIView Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeUI()
        presenter?.viewDidLoad()
    }

    func customizeUI() {
        self.title = "History"
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "HistoeyTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
    }
}

//MARK:- Hisory Presenter To view Protocol
extension HistoryViewController : HistoryPresenterToViewProtocol {
    func refreshUI() {
        tableView.reloadData()
    }
}

//MARK:- Table View Delegate and Datasource
extension HistoryViewController :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  presenter?.historyList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HistoeyTableViewCell, let data = presenter?.historyList?[indexPath.row] else {
            return UITableViewCell()
        }
        cell.populateData(history:data,user: presenter?.loggedInUser ?? "" )
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
