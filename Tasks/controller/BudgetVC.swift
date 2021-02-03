//
//  BudgetVC.swift
//  Budgets
//
//  Created by Mohammed Gamal on 5/31/18.
//  Copyright © 2018 codelabs. All rights reserved.
//
import Foundation
import UIKit
import JJFloatingActionButton

class BudgetVC: UIViewController  {
    

    @IBOutlet weak var remainingBalance: UILabel!
    @IBOutlet weak var totalBudget: UILabel!
    @IBOutlet weak var totalExp: UILabel!
   
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var budgetName: UILabel!
    
var budgets_data = [all_budget_data]()
    var calcs = calculate()
    var budget:Budget?
     var refresher : UIRefreshControl!
    
    
    @objc private func handleRefresh() {
        API.getBudgetData(budgetNameText: (budget?.b_name)!) { (error: Error?, budgets_data:[all_budget_data]?) in
            if let budgets_data = budgets_data {
                self.memo = budgets_data
                self.refresher.endRefreshing()
                self.tableview.reloadData()
                
            }
        }
    
}
    @objc private func handleCalculate() {
        API.calculateData(budgetNameText: (budget?.b_name)!) { (error:Error?, calc: calculate?) in
            if let _ = calc {
                self.remainingBalance.text = "\(calc!.remainingBalance)"
                self.totalBudget.text = "\(calc!.totalBudget)"
                self.totalExp.text = "\(calc!.totalExpenses)"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        handleRefresh()
       handleCalculate()
        self.hideKeyboardWhenTappedAround()
        
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "loading")
        refresher.addTarget(self, action: #selector (BudgetVC.handleRefresh), for: UIControlEvents.valueChanged)
        tableview.addSubview(refresher)
  
        let actionButton = JJFloatingActionButton()

        let item = actionButton.addItem()
        item.titleLabel.text = "Add Expense"
        item.imageView.image = UIImage(named: "Add Expense")
        item.buttonColor = .red
        item.buttonImageColor = .white
        
        item.action = { item in
            let alert = UIAlertController(title: "Add Expense", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            alert.addTextField(configurationHandler: { textField in
                textField.placeholder = "Expense Name"
                
                alert.addTextField(configurationHandler: { textField in
                    textField.placeholder = "Expense Amount"
                    textField.keyboardType = .numberPad
                })
                
                alert.addAction(UIAlertAction(title: "ADD", style: .default, handler: { action in
                    guard let expenseNameTxt = alert.textFields![0].text , !expenseNameTxt.isEmpty else {return}
                    guard let expenseAmountTxt = alert.textFields![1].text , !expenseAmountTxt.isEmpty else{return}
                    // send new budget to server
                       self.addNewExpenseToServer(expenseNameTxt: expenseNameTxt, expenseAmountTxt: expenseAmountTxt)
                }))
                
                self.present(alert, animated: true)
            })
        }
        
        let item2 = actionButton.addItem()
        item2.titleLabel.text = "Increase Budget"
        item2.imageView.image = UIImage(named: "Increase Budget")
        item2.buttonColor = .green
        item2.buttonImageColor = .white
        
        item2.action = { item in
            let alert = UIAlertController(title: "Add Revenue", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            alert.addTextField(configurationHandler: { textField in
                textField.placeholder = "Revenue Name"
                
                alert.addTextField(configurationHandler: { textField in
                    textField.placeholder = "Revenue Amount"
                    textField.keyboardType = .numberPad
                })
                
                alert.addAction(UIAlertAction(title: "ADD", style: .default, handler: { action in
                    guard let increaseNameTxt = alert.textFields![0].text , !increaseNameTxt.isEmpty else {return}
                    guard let increaseAmountTxt = alert.textFields![1].text , !increaseAmountTxt.isEmpty else{return}
                    // send new budget to server
                       self.addNewIncreaseToServer(increaseNameTxt: increaseNameTxt, increaseAmountTxt: increaseAmountTxt)
                }))
                
                self.present(alert, animated: true)
            })
        }
        
        
        
        view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        // remainingBalance.text = budget!.b_name
       // budgetName.text = budget?.b_name
        let budgetNameText = budgetName
    }
 var memo = [all_budget_data]()
    
    private func addNewExpenseToServer(expenseNameTxt : String , expenseAmountTxt : String){
        
        API.addExpense(expenseNameTxt: expenseNameTxt, expenseAmountTxt: expenseAmountTxt, budgetName: budget!.b_name) { (error:Error?, expense: all_budget_data?) in
            if let expense = expense {
                self.handleCalculate()
                self.memo.insert(expense, at: 0)
                self.tableview.beginUpdates()
                self.tableview.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
                self.tableview.endUpdates()
            }
        }
        
        
    }
    private func addNewIncreaseToServer(increaseNameTxt : String , increaseAmountTxt : String){
        
       API.addIncrease(increaseNameTxt: increaseNameTxt, increaseAmountTxt: increaseAmountTxt, budgetName: budget!.b_name) { (error:Error?, increase: all_budget_data?) in
            if let increase = increase {
                self.handleCalculate()
                self.memo.insert(increase, at: 0)
                self.tableview.beginUpdates()
                self.tableview.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
                self.tableview.endUpdates()
            }
        }
        
        
    }
}



extension BudgetVC:  UITableViewDataSource {
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return memo.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "YellowCell") as! YellowCell
            let all_name = memo[indexPath.row].e_name
            let revenueAmount = "\( memo[indexPath.row].amount)"
            cell.amount.text = revenueAmount
            cell.flagSwitch.isOn = memo[indexPath.row].flag
        
        let selectedTransaction = memo[indexPath.row]
        cell.bname = selectedTransaction.e_name
        cell.ibname = selectedTransaction.i_b_name
        cell.expenseActionHandler = { isOn in
            API.activateExpense(budgetNameText: self.budget!.b_name,
                                expenseName: selectedTransaction.e_name,
                                flag: isOn,
                                completion: { (error, calc) in
                                    self.remainingBalance.text = "\(calc!.remainingBalance)"
                                    self.totalBudget.text = "\(calc!.totalBudget)"
                                    self.totalExp.text = "\(calc!.totalExpenses)"
            })
        }
        
        cell.increaseActionHandler = { isOn in
            API.activateIncrease (budgetNameText: self.budget!.b_name,
                               increaseName: selectedTransaction.i_b_name,
                                flag: isOn,
                                completion: { (error, calc) in
                                    self.remainingBalance.text = "\(calc!.remainingBalance)"
                                    self.totalBudget.text = "\(calc!.totalBudget)"
                                    self.totalExp.text = "\(calc!.totalExpenses)"
            })
        }
        
        if all_name != ""
        {
            cell.name.text = all_name
            cell.containerView.backgroundColor = UIColor.red
            
        }
        else{
        let revenue = memo[indexPath.row].i_b_name
        cell.name.text = revenue
        cell.containerView.backgroundColor = UIColor.yellow
        
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndex = indexPath.row
        
    }
    
}

// handle delete

extension BudgetVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
}
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let select = memo[indexPath.row].i_b_name
        let increaseName = memo[indexPath.row]
        if select != ""
        {
        let deleteAction = UITableViewRowAction(style: .normal , title: "Delete"){ (action: UITableViewRowAction, indexPath : IndexPath) in
            self.handleIncreaseDelete(budget: self.budget! , i_b_name : increaseName , indexpath: indexPath)
        }
        deleteAction.backgroundColor = .red
        return [deleteAction]
    } else
        {
            let deleteAction = UITableViewRowAction(style: .normal , title: "Delete"){ (action: UITableViewRowAction, indexPath : IndexPath) in
                self.handleExpenceDelete(budget: self.budget! , e_name : increaseName , indexpath: indexPath)
                
            }
            deleteAction.backgroundColor = .red
            return [deleteAction]
            
        }
}
    private func handleIncreaseDelete(budget: Budget ,i_b_name : all_budget_data , indexpath : IndexPath){
        API.deleteIncreaseCell(b_name: budget.b_name , i_b_name : i_b_name.i_b_name){ ( error : Error?, success : Bool) in
            if success {
                if let index = self.memo.index(of: i_b_name ){
                    self.memo.remove(at: index)
                    
                    // remove Row
                    self.handleCalculate()
                    self.tableview.beginUpdates()
                    self.tableview.deleteRows(at: [indexpath], with: .automatic)
                    self.tableview.endUpdates()
                } else {
                    self.tableview.reloadData()
                }
                
            }
        }
    }
    private func handleExpenceDelete(budget: Budget , e_name : all_budget_data , indexpath : IndexPath){
        API.deleteExpenceCell ( b_name: budget.b_name , e_name : e_name.e_name ){ ( error : Error?, success : Bool) in
            if success {
                if let index = self.memo.index(of: e_name ){
                    self.memo.remove(at: index)
                    
                    // remove Row
                    self.handleCalculate()
                    self.tableview.beginUpdates()
                    self.tableview.deleteRows(at: [indexpath], with: .automatic)
                    self.tableview.endUpdates()
                    
                } else {
                    self.tableview.reloadData()
                }
            }
        }
    }
}

