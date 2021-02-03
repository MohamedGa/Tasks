//
//  YellowCell.swift
//  Budgets
//
//  Created by Mohammed Gamal on 6/4/18.
//  Copyright © 2018 codelabs. All rights reserved.
//

import UIKit

typealias ActionHandler = (Bool) -> ()

class YellowCell: UITableViewCell {
    
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var amount: UILabel!
    
    @IBOutlet weak var flagSwitch: UISwitch!
    var bname: String?
    var ibname: String?
    var expenseActionHandler: ActionHandler?
     var increaseActionHandler: ActionHandler?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.addShadow(cornerRadius: 10)
        self.backgroundColor = UIColor.clear
        self.contentView.addShadow(cornerRadius: 5,
                                   shadowRadius: 2,
                                   shadowColor: UIColor.black,
                                   opacity: 0.5)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func switchValueChanged(_ sender: Any) {
        // check if the cell is income or expense (check name == "")
        expenseActionHandler!(flagSwitch.isOn)
        increaseActionHandler!(flagSwitch.isOn)
        // else
        // inconeActionHandler(.....)
    }
}

