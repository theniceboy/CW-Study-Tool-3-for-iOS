//
//  Gib.swift
//  StudyTool3
//
//  Created by 陈为 on 9/19/15.
//  Copyright © 2015 David Chen. All rights reserved.
//

import UIKit
import Foundation

func ShowAlertMessage (parrent:UIViewController, title:String, message:String) {
    let alert = UIAlertController (title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert);
    let okAction = UIAlertAction (title: "OK", style: UIAlertActionStyle.Default, handler: nil)
    alert.addAction(okAction)
    parrent.presentViewController(alert, animated: true, completion: nil)
}

class user {
    var username: String, password: String
    init () {
        username = ""
        password = ""
    }
    init (uname: String, pword: String) {
        username = uname
        password = pword
    }
}
var me: user = user()