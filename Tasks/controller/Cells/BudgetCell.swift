//
//  BudgetCell.swift
//  Budgets
//
//  Created by Ali Amin on 5/26/18.
//  Copyright © 2018 codelabs. All rights reserved.
//

import UIKit

class BudgetCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var budgetAmount: UILabel!
    
    @IBOutlet weak var createdAt: UILabel!
    
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

}
