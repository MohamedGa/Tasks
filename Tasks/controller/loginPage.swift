//
//  ViewController.swift
//  Budgets
//
//  Created by Mohammed Gamal on 5/13/18.
//  Copyright © 2018 codelabs. All rights reserved.
//



import Alamofire
import SwiftyJSON
import UIKit
//import GoogleSignIn
import FirebaseAnalytics
import FacebookLogin
import FBSDKLoginKit

import FacebookCore


class loginPage: UIViewController , UITextFieldDelegate {
    @IBOutlet weak var facebookButtonHolder: UIView!
    var faceBookButton: UIButton?
    
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
        navigationController?.navigationBar.barTintColor = UIColor.darkGray
        
       
        
        //creating button FB
        faceBookButton = UIButton(frame: CGRect(x: 0,
                                                 y: 0,
                                                 width: facebookButtonHolder.bounds.size.width,
                                                 height: facebookButtonHolder.bounds.size.height))
        facebookButtonHolder.addSubview(faceBookButton!)
        faceBookButton!.addTarget(self, action: #selector(fbButtonTapped), for: .touchUpInside)
       
        faceBookButton!.setTitleColor(UIColor.white, for: .normal)
        faceBookButton!.backgroundColor = UIColor.clear
     
        
        
        // implement buttom of google sign in
        
       // GIDSignIn.sharedInstance().uiDelegate = self
        
        // Uncomment to automatically sign in the user.
        //GIDSignIn.sharedInstance().signInSilently()
        
        // TODO(developer) Configure the sign-in button look/feel
        // ...
        signInBtn.addShadow()
      
        registerBtn.addShadow()
       self.hideKeyboardWhenTappedAround()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        faceBookButton!.frame = CGRect(x: 0,
                                       y: 0,
                                       width: facebookButtonHolder.bounds.size.width,
                                       height: facebookButtonHolder.bounds.size.height)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        
        return true
        
    }
    
    @objc func fbButtonTapped() {
        
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [.email],
                           viewController: self) { (loginResult) in
                            switch loginResult {
                            case .failed(let error):
                                AlertManager.showAlert(error.localizedDescription,
                                                       inViewController: self)
                            case .cancelled:
                                return
                            case .success(_, _, let accessToken):
                                let req = GraphRequest(graphPath: "me",
                                                            parameters: ["fields":"email, id, name"],
                                                            tokenString: accessToken.tokenString,
                                                            version: nil,
                                httpMethod: HTTPMethod(rawValue: "GET"))
                                
                                req.start(completionHandler: { (_, json, error) in
                                    if let error = error {
                                        AlertManager.showAlert(error.localizedDescription,
                                                               inViewController: self)
                                    
                                        
                                    } else {
                                        
                                        API.register(name: (json as! [String : String])["name"]!, email: (json as! [String : String])["email"]!,password: (json as! [String : String])["id"]! , completion: { (error, success,state) in
                                                            // Stop loading indicator
                                                 
                                                            self.goToHomePage()
                                            })
                    
                                    }
                                })
                                break
                                
                            }
        }
    }
    
    
    func goToHomePage() {
        guard let window = UIApplication.shared.keyWindow else { return}
        let sb = UIStoryboard(name: "Main", bundle: nil)
        var vc : UIViewController
        vc = sb.instantiateViewController(withIdentifier: "HomeNavigationController")
        window.rootViewController = vc
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
    }
    //////// web service Login
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    
    @IBAction func signINTapped(_ sender: UIButton) {
        guard let email = emailTF.text, !email.isEmpty else {return}
        guard let password = passwordTF.text, !password.isEmpty else {return}
        
    
        API.login(email: email, password: password) { (error: Error? , success : Bool) in
            if success {
                print("OK")
                
                self.goToHomePage()
            }
            else
            {
                print("notOK")
                // say any thing
            }
            
                }
        
        }
    }
    
    
    
    
    
    
    
        
        

   






