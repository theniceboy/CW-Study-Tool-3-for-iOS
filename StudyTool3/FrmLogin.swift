//
//  FrmLogin.swift
//  StudyTool3
//
//  Created by 陈为 on 9/18/15.
//  Copyright © 2015 David Chen. All rights reserved.
//

import UIKit
import Parse

class FrmLogin: UIViewController {

    @IBOutlet weak var tbUsername: UITextField!
    @IBOutlet weak var tbPassword: UITextField!
    
    @IBAction func btnLoginTapped(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let testObject = PFObject(className: "TestObject")
        testObject["foo"] = "bar"
        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("Object has been saved.")
        }
    }
}
