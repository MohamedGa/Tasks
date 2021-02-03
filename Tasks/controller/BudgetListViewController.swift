//
//  BudgetListViewController.swift
//  Budgets
//
//  Created by Ali Amin on 5/26/18.
//  Copyright © 2018 codelabs. All rights reserved.
//

import Foundation
import UIKit
import SideMenu


class BudgetListViewController: UIViewController , UISearchBarDelegate {
  //  @IBOutlet weak var searchBarContainerView: UIView!
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var searchBarBtn: UIBarButtonItem!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var data: [Task]?
    var tasks = [Task]()
    
    var refresher : UIRefreshControl!
  //  @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func slideMenuBtn(_ sender: Any) {
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
        
        // Similarly, to dismiss a menu programmatically, you would do this:
       // dismiss(animated: true, completion: nil)
    }
    @objc func handleClick (){
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
        
    }
   
   
    
    @IBAction func addBtn(_ sender: Any) {
        print ( " Add New Item" )
        
        let alert = UIAlertController(title: "Add Budget", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
       
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "BUDGET NAME"
           
            alert.addTextField(configurationHandler: { textField in
                textField.placeholder = "BUDGET AMOUNT"
                textField.keyboardType = .numberPad
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            guard let budgetNameTxt = alert.textFields![0].text , !budgetNameTxt.isEmpty else {return}
            guard let budgetAmountTxt = alert.textFields![1].text , !budgetAmountTxt.isEmpty else{return}
            // send new budget to server
     //       self.addNewBudgetToServer(budgetNameTxt: budgetNameTxt, budgetAmountTxt: budgetAmountTxt)
            self.tableView.reloadData()
          self.handleRefresh()
        }))
        self.present(alert, animated: true)
    })
        self.tableView.reloadData()
        self.handleRefresh()
    }
    
//    private func addNewBudgetToServer(budgetNameTxt : String , budgetAmountTxt : String){
//
//        API.addBudget(budgetNameTxt: budgetNameTxt, budgetAmountTxt: budgetAmountTxt) { (error:Error?, budget: Budget?) in
//            if let budget = budget {
//                self.budgets.insert(budget, at: 0)
//                self.tableview.beginUpdates()
//                self.tableview.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
//                self.tableview.endUpdates()
//                self.tableView.reloadData()
//                self.handleRefresh()
//            }
//        }
//    }
    @IBAction func searchOpen(_ sender: UIBarButtonItem) {
        searchController.isActive = true
        setup()
        navigationItem.searchController = searchController
    }
    
    func setup() {
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.sizeToFit()
    }

    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationItem.searchController = nil
       searchController.isActive = false
        /* Cannot access tableview constraints from here because extension is outside of the class */
    }
    @objc func handleRefresh() {
        API.getTasks { (error: Error?, tasks:[Task]?) in
            if let tasks = tasks {
                self.tasks = tasks
                
                self.data = self.tasks
                if let refresher = self.refresher {
                    refresher.endRefreshing()
                }
                
                self.tableview.reloadData()
                
            }
        }
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//            navigationItem.hidesSearchBarWhenScrolling = false
//       // navigationItem.searchController?.isActive = true
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//    tableView.reloadData()
//            navigationItem.hidesSearchBarWhenScrolling = true
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  tableView.dataSource = self
     //   tableView.delegate = self
      //  searchBar.delegate = self
        navigationController?.navigationBar.barTintColor = UIColor.darkGray
        self.handleRefresh()
        addBtn.addShadow()
       self.hideKeyboardWhenTappedAround()
        //searchBar()
       // searchBarContainerView.backgroundColor = UIColor.darkGray
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "loading")
     refresher.addTarget(self, action: #selector (BudgetListViewController.handleRefresh), for: UIControlEvents.valueChanged)
        tableview.addSubview(refresher)
     //   tableView.reloadData()
        
        let menuController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController")
       let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: menuController)
        // UISideMenuNavigationController is a subclass of UINavigationController, so do any additional configuration
        // of it here like setting its viewControllers. If you're using storyboards, you'll want to do something like:
        // let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as! UISideMenuNavigationController
      SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController

        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the view controller it displays!
      SideMenuManager.default.menuAddPanGestureToPresent(toView: self.view)
      SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.view)
        
        ///
        searchController.searchBar.delegate = self
       searchController.searchBar.tintColor = .white
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        if let bg = self.searchTextField?.subviews.first {
            bg.backgroundColor = .white
            bg.layer.cornerRadius = 10
            bg.clipsToBounds = true
        }
       
        
    }
    
    private lazy var searchTextField: UITextField? = { [unowned self] in
        var textField: UITextField?
        self.searchController.searchBar.subviews.forEach({ view in
            view.subviews.forEach({ view in
                if let view  = view as? UITextField {
                    textField = view
                }
            })
        })
        return textField
        }()
    
    
    @IBOutlet weak var tableview: UITableView!
   
 
   
}
extension  BudgetListViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return 6
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BudgetCell") as! BudgetCell
        
        cell.name.text = tasks[indexPath.row].t_title
        let bugdetAmount = "\( tasks[indexPath.row].t_text)"
        cell.budgetAmount.text = bugdetAmount
        cell.createdAt.text = tasks[indexPath.row].t_date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    // segue
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndex = indexPath.row
 
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        data = searchText.isEmpty ? tasks : data!.filter({(task: Task) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return task.t_title.range(of: searchText, options: .caseInsensitive) != nil
        })
        
        tableView.reloadData()
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let budgetViewController = segue.destination as? BudgetVC {
//            budgetViewController.budget = budgets[(tableview.indexPathForSelectedRow?.row)!]
//        }
//    }
}
// handle Delete
extension BudgetListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let budget = budgets[indexPath.row]
//        let deleteAction = UITableViewRowAction(style: .normal , title: "Delete"){ (action: UITableViewRowAction, indexPath : IndexPath) in
//            self.handleDelete(budget: budget , indexpath: indexPath)
//        }
//
//        deleteAction.backgroundColor = .red
//        return [deleteAction]
//    }
    
    
    
//    private func handleDelete(budget: Budget , indexpath : IndexPath){
//        API.deleteBudget(b_name: budget.b_name ){ ( error : Error?, success : Bool) in
//            if success {
//                if let index = self.data?.index(of: budget ){
//
//                    self.data?.remove(at: index)
//
//                    // remove Row
//                    self.tableview.beginUpdates()
//                    self.tableview.deleteRows(at: [indexpath], with: .automatic)
//                    self.tableview.endUpdates()
//                   self.tableview.reloadData()
//                    self.handleRefresh()
//
//
//
//
//                } else {
//                    self.tableview.reloadData()
//
//
//
//                }
//            }
//        }
//    }
}

