//
//  ProfileVC.swift
//  Budgets
//
//  Created by apple on 6/8/18.
//  Copyright © 2018 codelabs. All rights reserved.
//

import UIKit
import SideMenu

class ProfileVC: UIViewController {
    let vc = BudgetListViewController()
    
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var numOfBudgetsLbl: UILabel!
    @IBOutlet weak var numOfBudgetsView: UIView!
    
    @IBOutlet var passwordLbl: UILabel!
    @IBOutlet weak var budgetView: UIView!
    @IBOutlet weak var emailLbl: UILabel!
    
    @objc private func handleUserData() {
        API.getUserData { (error:Error?, user: [userData]) in
            guard var ff = user.first?.email else { AlertManager.showAlert("Try Again", inViewController: self)
                return
            }
            guard var kk = user.first?.name else { AlertManager.showAlert("Try Again", inViewController: self)
                return
            }
            guard var ll = user.first?.password else { AlertManager.showAlert("Try Again", inViewController: self)
                return
            }
            self.emailLbl?.text = "\(ff)"
            
            self.nameLbl?.text = "\(kk)"
           // self.passwordLbl?.text = "\(ll)"
        }
    }
    
    
    @IBAction func menuTapped(_ sender: UIBarButtonItem) {
          present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    
  
    
    @IBAction func editName(_ sender: Any) {
        print ( " Add New Name" )
        
        let alert = UIAlertController(title: "Add New Name", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "New Name"
            
           
            })
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                guard let newNameTxt = alert.textFields![0].text , !newNameTxt.isEmpty else {return}
               
                // send new budget to server
                self.updateNewName(newNameTxt: newNameTxt)
                self.handleUserData()
            }))
            
            self.present(alert, animated: true)
        }
  


    @IBAction func editEmail(sender: UIButton) {
   
    
    print ( " Add New Email" )
        
        let alert = UIAlertController(title: "Add New Email", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "New Email"
            
            
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            guard let newEmailTxt = alert.textFields![0].text , !newEmailTxt.isEmpty else {return}
            
            // send new budget to server
            self.updateNewEmail(newEmailTxt: newEmailTxt)
            self.handleUserData()
        }))
        
        self.present(alert, animated: true)
    }
    

    @IBAction func editPassword(sender: UIButton) {
    
    
    
    print ( " Add New Password" )
        
        let alert = UIAlertController(title: "Add New Password", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "New Password"
            
            
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            guard let newPasswordTxt = alert.textFields![0].text , !newPasswordTxt.isEmpty else {return}
            
            // send new budget to server
            self.updateNewPassword(newPasswordTxt: newPasswordTxt)
            self.handleUserData()
        }))
        
        self.present(alert, animated: true)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleUserData()
        self.hideKeyboardWhenTappedAround()
       


        //  budgetView.addGradientWithColor(color: UIColor.yellow)
//        let menuController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController")
//        let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: menuController)
//        // UISideMenuNavigationController is a subclass of UINavigationController, so do any additional configuration
//        // of it here like setting its viewControllers. If you're using storyboards, you'll want to do something like:
//        // let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as! UISideMenuNavigationController
//        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
//        
//        // Enable gestures. The left and/or right menus must be set up above for these to work.
//        // Note that these continue to work on the Navigation Controller independent of the view controller it displays!
//        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.view)
//        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.view)
       
      API.getBudgetCount{ (error: Error?, count: Int) in
        
           let gg = String( count)
        self.numOfBudgetsLbl.text = gg
        
        
        }
       
        
    }
    
    @objc func handleClick (){
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
        
    }
 
    
    private func updateNewName ( newNameTxt : String ){
        
        API.updateUserData (newEmailTxt: "", newNameTxt: newNameTxt , newPasswordTxt: "" ) { (error:Error?, user: [userData]) in
            
            //   self.emailLbl?.text = "\(user.first!.email)"
            self.nameLbl?.text = "\(user.first!.name)"
            // self.passwordLbl?.text = "\(user.first!.password)"
            
        }
    }
    private func updateNewEmail ( newEmailTxt : String ){
        
        API.updateUserData (newEmailTxt: newEmailTxt, newNameTxt: "" , newPasswordTxt: "" ) { (error:Error?, user: [userData]) in
            guard var ff = user.first?.email else { AlertManager.showAlert("Try Again", inViewController: self)
                return
            }
            self.emailLbl?.text = "\(ff)"
            //  self.nameLbl?.text = "\(user.first!.name)"
            //  self.passwordLbl?.text = "\(user.first!.password)"
            let def = UserDefaults.standard
            def.setValue(newEmailTxt, forKey: "email")
            def.synchronize()
            
        }
    }
    private func updateNewPassword ( newPasswordTxt : String ){
        
        API.updateUserData (newEmailTxt: "", newNameTxt: "" , newPasswordTxt: newPasswordTxt ) { (error:Error?, user: [userData]) in
            guard var ff = user.first?.password else { AlertManager.showAlert("Try Again", inViewController: self)
                return
            }
            self.passwordLbl?.text = "\(ff)"
            //   self.emailLbl?.text = "\(user.first!.email)"
            // self.nameLbl?.text = "\(user.first!.name)"
            
            
        }
    }
}


