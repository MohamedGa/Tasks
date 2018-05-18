//
//  registerPageViewController.swift
//  Budgets
//
//  Created by Mohammed Gamal on 5/16/18.
//  Copyright © 2018 codelabs. All rights reserved.
//

import UIKit

class registerPageViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTesxtField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        
        let userName = userNameTextField.text;
        let userEmail = userEmailTextField.text;
        let userPassword = userPasswordTesxtField.text;
        let userConfirmPassword = confirmPasswordTextField.text;
        let api_token=111 ;
        
        if ((userName?.isEmpty)! || (userEmail?.isEmpty)! || (userPassword?.isEmpty)! || (userConfirmPassword?.isEmpty)!)
        {
            //Display the messsage
            displayMyAlertMessage( userMessage: "All Field are required")
            return;
        }
        // check the password match confirmPassword
        if (userPassword != userConfirmPassword )
        {
            // Display alert message
            displayMyAlertMessage( userMessage: "Password Don't Match")
            return;
            
        }
        
        // STORE DATA
        
        
        
        
        
    
    }
        
        func displayMyAlertMessage(userMessage:String)
        {
            var myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            myAlert.addAction(okAction);
            
            self.present(myAlert,animated: true,completion: nil)
            
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


