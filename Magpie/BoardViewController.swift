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
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: FUITableViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        navigationItem.title = "Magpie Board"
        
        let ref = FIRDatabase.database().reference()
        let query = ref.child("lists").queryOrderedByKey()
        
        dataSource = tableView.bind(to: query, populateCell: { (tableView: UITableView, indexPath: IndexPath, snapshot: FIRDataSnapshot) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(withIdentifier: "boardTableViewCell", for: indexPath)
            guard let value = snapshot.value as? NSDictionary else { return cell }
            
            let title = value["title"] as? String ?? ""
            cell.textLabel?.text = title
            
            return cell
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let listViewController = segue.destination as? ListViewController,
            let selectedIndexPath = tableView.indexPathForSelectedRow,
            let item = dataSource?.items[selectedIndexPath.row]
            else { return }
        
        listViewController.listData = item
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "listSelected", sender: indexPath)
    }
}
