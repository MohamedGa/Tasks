//
//  forgetPasswordViewController.swift
//  Budgets
//
//  Created by Mohammed Gamal on 5/23/18.
//  Copyright © 2018 codelabs. All rights reserved.
//

import UIKit

class forgetPasswordViewController: UIViewController {

    @IBOutlet weak var resetBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        resetBtn.addShadow()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var emailTF: UITextField!
    
    
    @IBAction func sendEmail(_ sender: Any) {
        
  guard let email = emailTF.text, !email.isEmpty else {return}
        
        API.forgetPassword(email: email) { (error: Error? , success : Bool) in
            if success {
                print("nice")
                // say any thing
            }
            else
            {
                print("THe password sent to UR Inbox")
                // say any thing
            }
        
        
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

}

