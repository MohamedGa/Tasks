//
//  registerPageViewController.swift
//  Budgets
//
//  Created by Mohammed Gamal on 5/16/18.
//  Copyright © 2018 codelabs. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class registerPageViewController: UIViewController , UITextFieldDelegate{

    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTesxtField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.delegate = self
        userNameTextField.delegate = self
        confirmPasswordTextField.delegate = self
        userEmailTextField.delegate = self
        registerButton.addShadow()
        self.hideKeyboardWhenTappedAround()
    }
  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        
        return true
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateViewMoving(up: true, moveValue: 150)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        animateViewMoving(up: false, moveValue: 150)
    }
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        
        let name = userNameTextField.text!;
        let email = userEmailTextField.text!;
        let password = userPasswordTesxtField.text!;
        let confirmPassword = confirmPasswordTextField.text!;
        let api_token=111 ;
        
        if (name.isEmpty || (email.isEmpty) || (password.isEmpty) || (confirmPassword.isEmpty))
        {
            
            //Display the messsage
           // displayMyAlertMessage( userMessage: "All Field are required")
            return;
        }
        
        // check the password match confirmPassword
        if ( password != confirmPassword )
        {
            // Display alert message
            
           // displayMyAlertMessage( userMessage: "Password Don't Match")
            
            return;
            
        }
        
        
        
        API.register(name: name , email: email, password: password ){(error :Error? , success : Bool,state : Bool) in
            if success{
                
                if state == true {
                    API.login(email: email, password: password) { (error: Error? , success : Bool) in
                        if success {
                            print("OK")
                            
                            guard let window = UIApplication.shared.keyWindow else { return}
                            let sb = UIStoryboard(name: "Main", bundle: nil)
                            var vc : UIViewController
                            vc = sb.instantiateViewController(withIdentifier: "HomeNavigationController")
                            window.rootViewController = vc
                            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
                        }
                        else
                        {
                           
                            print("notOK")
                            // say any thing
                        
                        }
                        }
                    
                    
                }else
                {
                print("OK")
            
                //Restart App to loginto main page
                
                guard let window = UIApplication.shared.keyWindow else { return}
                let sb = UIStoryboard(name: "Main", bundle: nil)
                var vc : UIViewController
                vc = sb.instantiateViewController(withIdentifier: "HomeNavigationController")
                window.rootViewController = vc
                
                UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
                }
                
            }
            else
            {
                // ccc
            }
            
        
    }
            
         func displayMyAlertMessage(userMessage:String)
         {
            let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            myAlert.addAction(okAction)
            
                 self.present(myAlert,animated: true,completion: nil)
            
        }

}
    
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}


