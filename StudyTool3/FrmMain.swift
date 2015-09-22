//
//  FrmMain.swift
//  StudyTool3
//
//  Created by 陈为 on 9/19/15.
//  Copyright © 2015 David Chen. All rights reserved.
//

import UIKit
import Parse

class FrmMain: UITableViewController {
    
    // MARK: - Vars & Lets
    var groups: [String] = []
    var cur_group: String = ""
    
    // MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        let query = PFQuery(className: "groups").whereKey("username", equalTo: me.username)
        do {
            let objects = try! query.findObjects()
            self.groups.removeAll()
            for object in objects {
                self.groups.append(object["name"] as! String)
            }
            self.tableView.reloadData()
        } catch let error as NSError {
            ShowAlertMessage(self, title: "Error!", message: String(error))
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }

    struct Storyboard {
        static let tableViewCellReUseIdentifier = "group"
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.tableViewCellReUseIdentifier, forIndexPath: indexPath)
        cell.textLabel?.text = groups[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        cur_group = groups[indexPath.row]
        return indexPath
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "fMain_fWords") {
            let dvc = segue.destinationViewController as! FrmWords
            dvc.title = cur_group
            print(cur_group)
        }
    }
}
