//
//  LogInViewController.swift
//  Magpie
//
//  Created by Donny Kurniawan on 28/3/17.
//  Copyright © 2017 Donny Kurniawan. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var ref: FIRDatabaseReference!

    override func viewDidAppear(_ animated: Bool) {
        if FIRAuth.auth()?.currentUser != nil {
            print("SUCCESS")
        }
        ref = FIRDatabase.database().reference()
    }
    
    @IBAction func didTapLogin(_ sender: AnyObject) {
        guard let email = self.emailTextField.text, let password = self.passwordTextField.text else {
            print("CANNOT BE EMPTY")
            return
        }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            
            guard let user = user, error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            self.performSegue(withIdentifier: "successLogIn", sender: nil)
        })

    }
}
