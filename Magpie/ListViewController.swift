//
//  ListViewController.swift
//  Magpie
//
//  Created by Donny Kurniawan on 30/3/17.
//  Copyright © 2017 Donny Kurniawan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabaseUI

class ListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: FUICollectionViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ref = FIRDatabase.database().reference()
        let query = ref.child("lists").queryOrderedByKey()
        
        self.dataSource = self.collectionView.bind(to: query, populateCell: { (collectionView: UICollectionView, indexPath: IndexPath, snapshot: FIRDataSnapshot) -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listCollectionViewCell", for: indexPath)
            
            guard let myCell = cell as? ListCollectionViewCell,
                let value = snapshot.value as? NSDictionary
                else { return cell }
            
            let title = value["title"] as? String ?? ""
            myCell.title.text = title
            
            return cell
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }    
}
