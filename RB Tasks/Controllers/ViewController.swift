//
//  ViewController.swift
//  RB Tasks
//
//  Created by Hashir Saeed on 10/05/2019.
//  Copyright © 2019 Hashir Saeed. All rights reserved.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.userLoginSucess(_:)), name: NSNotification.Name(rawValue: "SuccessfulSignInNotification"), object: nil)
        
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    // Implement these methods only if the GIDSignInUIDelegate is not a subclass of
    // UIViewController.
    
    // Stop the UIActivityIndicatorView animation that was started when the user
    // pressed the Sign In button
    
    // handle notification
    @objc func userLoginSucess(_ notification: NSNotification) {
        print(notification.userInfo ?? "")
    
        if let dict = notification.userInfo as NSDictionary? {
            let name  = dict["fullName"]
            let email = dict["email"]
            let userId = dict["userId"]
            print("*****Name From Segue***** \(name!)")
            print("*****Name From Segue***** \(email!)")
            print("*****Name From Segue***** \(userId!)")
            
            //Saving Values in the Local Db..(If the Values are Duplicate or same. it will just override them.)
            UserDefaults.standard.set(name, forKey: "name")
            UserDefaults.standard.set(email, forKey: "email")
            
            performSegue(withIdentifier: "loginToDashboard", sender: self)
            
            
            
        }
    }
    
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    

}

