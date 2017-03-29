//
//  BoardViewController.swift
//  Magpie
//
//  Created by Donny Kurniawan on 28/3/17.
//  Copyright © 2017 Donny Kurniawan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabaseUI

class BoardViewController: UIViewController, UITableViewDelegate {
    var dataSource: FUITableViewDataSource?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ref = FIRDatabase.database().reference()
        let query = ref.child("lists").queryOrderedByKey() /*or a more sophisticated query of your choice*/
        
        self.dataSource = self.tableView.bind(to: query, populateCell: { (tableView: UITableView, indexPath: IndexPath, snapshot: FIRDataSnapshot) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "listTableViewCell", for: indexPath)
            guard let value = snapshot.value as? NSDictionary else { return cell }
            
            let title = value["title"] as? String ?? ""
            cell.textLabel?.text = title
            
            return cell
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "detail", sender: indexPath)
    }    
}
