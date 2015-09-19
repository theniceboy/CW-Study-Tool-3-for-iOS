//
//  FrmLogin.swift
//  StudyTool3
//
//  Created by David Chen on 9/18/15.
//  Copyright © 2015 David Chen. All rights reserved.
//

import UIKit
import Parse

class FrmLogin: UIViewController {

    @IBOutlet weak var tbUsername: UITextField!
    @IBOutlet weak var tbPassword: UITextField!

    @IBAction func btnLoginTapped(sender: AnyObject) {
        let username = tbUsername.text
        let password = tbPassword.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).encrypt()
        var query = PFQuery(className:"users")
        query.whereKey("username", equalTo: tbUsername.text).whereKey("pass", equalTo: <#T##AnyObject#>)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        print(object.objectId)
                    }
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo!)")
            }
        }
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
