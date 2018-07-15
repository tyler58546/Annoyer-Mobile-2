//
//  AboutTableViewController.swift
//  Annoyer Mobile 2
//
//  Created by Tyler Knox on 7/14/18.
//  Copyright © 2018 tyler58546. All rights reserved.
//

import UIKit

class AboutTableViewController: UITableViewController {

    let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    let build = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 0 {
            return "Annoyer v\(version) (\(build))\nCopyright © 2018 Tyler Knox"
        }
        return nil
    }
    

}
