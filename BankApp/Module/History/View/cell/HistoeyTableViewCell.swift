//
//  HistoeyTableViewCell.swift
//  BankApp
//
//  Created by User on 31/01/21.
//

import UIKit

class HistoeyTableViewCell: UITableViewCell {

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var transactionTypeLabel: UILabel!
    @IBOutlet weak var transactionDateLabel: UILabel!
    
    //MARK:- View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //MARK:- View PopulateDate
    func populateData(history:History, user:String) {
        let isPayNow = (history.type == "Pay Now")
        let isCredited = (history.payee ?? "" == user)
        amountLabel.text = "\(history.amount)"
        var transaction:String = ""
        if(isCredited) {
            transaction = String(format: "Cedited  From (%@)", history.name ?? "")
        }else {
            transaction = isPayNow ? (String(format: "%@  to (%@)", history.type ?? "" ,history.payee ?? "")) : history.type  ?? ""
        }
        transactionTypeLabel.text = transaction
        transactionDateLabel.text = history.date
        amountLabel.textColor = isPayNow ? (isCredited ? UIColor(named: "darkGreen") : UIColor.red) : UIColor(named: "darkGreen")
    }
}
