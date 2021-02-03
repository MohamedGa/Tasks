//
//  MenuViewController.swift
//  Budgets
//
//  Created by Ali Amin on 5/26/18.
//  Copyright © 2018 codelabs. All rights reserved.
//

import UIKit
import SideMenu


class MenuViewController: UIViewController {

    var tito = Budget()
    @IBOutlet weak var emailLbl: UILabel!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var colorView: UIView!
   
   
    @IBAction func logOut(_ sender: Any) {
    
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
                let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeLogIn")
        
                let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
                appDel.window?.rootViewController = loginVC
        
        
        //        UserDefaults.standard.set(false, forKey: "email")
//        UserDefaults.standard.synchronize()
//        
//        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "loginPage") as! loginPage
//        
//        let appDel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
//        
//        appDel.window?.rootViewController = loginVC
    }
    
    
    // handle color gradiant
   
    
    
    
  //  gradient.colors = [UIColor.white.cgColor, UIColor.black.cgColor]
    
  //  view.layer.insertSublayer(gradient, at: 0)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
handleUserData2()
   
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    @objc private func handleUserData2() {
        API.getUserData { (error:Error?, user: [userData]) in
            guard var ff = user.first?.email else {
                return
            }
            guard var kk = user.first?.name else {
                return
            }
            self.emailLbl.text = "\(ff)"
             self.nameLbl.text = "\(kk)"
            //                self.totalBudget.text = "\(calc!.totalBudget)"
            //                self.totalExp.text = "\(calc!.totalExpenses)"
            
        }
    }
    
    @IBAction func budgetListTapped(_ sender: Any) {
        let navigationController = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
        navigationController.viewControllers = [navigationController.storyboard?.instantiateViewController(withIdentifier: "main")] as! [UIViewController]
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func profileButtonTapped(_ sender: Any) {
        let navigationController = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
        navigationController.viewControllers = [navigationController.storyboard?.instantiateViewController(withIdentifier: "ProfileVC")] as! [UIViewController]
        
        dismiss(animated: true, completion: nil)
    }
    
}
extension UIView {
    func addGradientWithColor(color: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [UIColor.clear.cgColor, color.cgColor]
        
        self.layer.insertSublayer(gradient, at: 0)
    }
}
