//
//  PortalTableViewController.swift
//  Feed
//
//  Created by Gregory Zarski on 12/26/16.
//  Copyright © 2016 Gregory Zarski. All rights reserved.
//

import UIKit

class PortalTableViewController: UITableViewController {
    var portals: [[Portal]]? = [[
        Portal(type: PortalType.global, key: nil, text: "All", imageUrl: nil),
        Portal(type: PortalType.local, key: nil, text: "Local", imageUrl: nil)
    ]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if let portals = self.portals {
            return portals.count
        }
        
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let section = self.portals?[section] {
            return section.count
        }
        
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Portal", for: indexPath) as! PortalTableViewCell
        
        if let portal = self.portals?[indexPath.section][indexPath.row] {
            cell.portalText?.text = portal.text
        }

        return cell
    }
}
