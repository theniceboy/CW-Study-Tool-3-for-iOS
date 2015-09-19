//
//  FrmLogin.swift
//  StudyTool3
//
//  Created by David Chen on 9/18/15.
//  Copyright © 2015 David Chen. All rights reserved.
//

import UIKit
import Parse

class FrmLogin: UIViewController, UITextFieldDelegate {

    // MARK: - Outlets
    @IBOutlet weak var tbUsername: UITextField!
    @IBOutlet weak var tbPassword: UITextField!
    
    // MARK: - Vars & Lets
    var login_state: Bool = false

    // MARK: - Actions
    @IBAction func btnLoginTapped(sender: AnyObject) {
        let username = tbUsername.text!
        let password = tbPassword.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).encrypt
        let query = PFQuery(className: "users").whereKey("username", equalTo: username)
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if (error == nil) {
                if (objects?.count > 0) {
                    self.login_state = true
                    for object in objects! {
                        if (object["password"] as? String != password) {
                            self.login_state = false
                            ShowAlertMessage(self, title: "Error", message: "Password incorrect!")
                            break
                        }
                    }
                } else {
                    self.login_state = false
                    ShowAlertMessage(self, title: "Error", message: "User not exists!")
                }
            } else {
                self.login_state = false
                ShowAlertMessage(self, title: "Error!", message: String(error?.userInfo))
            }
            if (self.login_state) {
                NSUserDefaults.standardUserDefaults().setValue(username, forKey: "username")
                NSUserDefaults.standardUserDefaults().setValue(password, forKey: "password")
                me.username = username
                me.password = password
                self.performSegueWithIdentifier("fLogin_fMain", sender: sender)
            }
        }
    }
    
    // MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        tbUsername.becomeFirstResponder()
    }
    
    // MARK: - TextField delegates
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if (textField == tbUsername) {
            tbUsername.resignFirstResponder()
            tbPassword.becomeFirstResponder()
        } else {
            tbPassword.resignFirstResponder()
            btnLoginTapped(textField)
        }
        return true
    }
}
