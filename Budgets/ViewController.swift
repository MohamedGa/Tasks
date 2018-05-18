//
//  ViewController.swift
//  Budgets
//
//  Created by Mohammed Gamal on 5/13/18.
//  Copyright © 2018 codelabs. All rights reserved.
//

import UIKit
import GoogleSignIn
import FirebaseAnalytics
import FacebookLogin
import FBSDKLoginKit

class ViewController: UIViewController , GIDSignInUIDelegate {
  
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //creating button
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.frame = CGRect(x: 20, y: 525
            , width: view.frame.width - 100, height: 40)
        view.addSubview(loginButton)
        
        // implement buttom of google sign in
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Uncomment to automatically sign in the user.
        //GIDSignIn.sharedInstance().signInSilently()
        
        // TODO(developer) Configure the sign-in button look/feel
        // ...

    }
  
        
        
    }
   






