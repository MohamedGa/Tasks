//
//  AlertManager.swift
//  Eserve
//
//  Created by Ali Amin on 3/2/18.
//  Copyright © 2018 eserve. All rights reserved.
//

import Foundation
import UIKit

typealias AlertCompletionHandler = () -> Void

class AlertManager {
    
    class func showAlert(_ message: String, inViewController: UIViewController, completionHandler: AlertCompletionHandler? = nil) {
        let alert = UIAlertController(title: "",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alertAction) in
            if let theHandler = completionHandler {
                theHandler()
            }
        }))
   
        inViewController.present(alert,
                                 animated: true,
                                 completion: nil)
    }
}
