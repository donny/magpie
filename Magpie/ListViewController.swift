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
    var listData: FIRDataSnapshot?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard
            let listData = listData,
            let listDataValue = listData.value as? NSDictionary
            else { return }
        
        let ref = FIRDatabase.database().reference()
        let query = ref.child("cards").queryOrdered(byChild: "list").queryEqual(toValue: listData.key)
        
        navigationItem.title = listDataValue["title"] as? String ?? ""
        
        dataSource = collectionView.bind(to: query, populateCell: { (collectionView: UICollectionView, indexPath: IndexPath, snapshot: FIRDataSnapshot) -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listCollectionViewCell", for: indexPath)
            
            guard let myCell = cell as? ListCollectionViewCell,
                let value = snapshot.value as? NSDictionary
                else { return cell }

            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 4
            
            myCell.title.text = value["title"] as? String ?? ""
            myCell.score.text = String(value["score"] as? Int ?? 0)
            
            return cell
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }    
}
