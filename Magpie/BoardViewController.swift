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
    var ref: FIRDatabaseReference!
    var dataSource: FUITableViewDataSource?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        ref = FIRDatabase.database().reference()
        
        
        
        
        ref = FIRDatabase.database().reference().child("lists")
        
        let query = ref.queryOrderedByKey() /*or a more sophisticated query of your choice*/
        
        let dataSource = self.tableView.bind(to: query, populateCell: { (tableView: UITableView, indexPath: IndexPath, snapshot: FIRDataSnapshot) -> UITableViewCell in
            
            let myCell = tableView.dequeueReusableCell(withIdentifier: "listTableViewCell", for: indexPath)
            
            guard let cell = myCell as? ListTableViewCell else {
                return myCell
            }
            
            let value = snapshot.value as! NSDictionary

            print(value)
            let someProp = value["title"] as? String ?? ""
            cell.title.text = someProp
            
            return cell
        })
        
        self.dataSource = dataSource
        
        self.getQuery().observe(.value, with: { snapshot in
            print("HELLO")
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "detail", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func getUid() -> String {
        return (FIRAuth.auth()?.currentUser?.uid)!
    }
    
    func getQuery() -> FIRDatabaseQuery {
//        return self.ref
//        return (ref?.child("user-posts").child(getUid()))!
        return self.ref.child("lists")
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let path: IndexPath = sender as? IndexPath else { return }
//        guard let detail: PostDetailTableViewController = segue.destination as? PostDetailTableViewController else {
//            return
//        }
//        let source = self.dataSource
//        guard let snapshot: FIRDataSnapshot = (source?.object(at: UInt((path as NSIndexPath).row)))! as? FIRDataSnapshot else {
//            return
//        }
//        detail.postKey = snapshot.key
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        getQuery().removeAllObservers()
    }
}
