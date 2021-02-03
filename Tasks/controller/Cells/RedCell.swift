//
//  RedCell.swift
//  Budgets
//
//  Created by Mohammed Gamal on 6/4/18.
//  Copyright © 2018 codelabs. All rights reserved.
//

import UIKit

class RedCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var expenseName: UILabel!
    
    @IBOutlet weak var expenseAmount: UILabel!
    
    @IBOutlet weak var redFlagSwitch: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
   // containerView.addShadow(cornerRadius: 10)
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
    
}

