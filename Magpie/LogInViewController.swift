//
//  LogInViewController.swift
//  Magpie
//
//  Created by Donny Kurniawan on 28/3/17.
//  Copyright © 2017 Donny Kurniawan. All rights reserved.
//

import UIKit
import Firebase
import Eureka
import APESuperHUD

class LogInViewController: FormViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ Section("Authentication")
            <<< EmailRow() { row in
                row.title = "Email"
                row.tag = "email"
            }
            <<< PasswordRow() {
                $0.title = "Password"
                $0.tag = "password"
            }
        
        let logInButton = UIBarButtonItem(title: "Log In", style: .plain, target: self, action: #selector(logInButtonTapped))
        navigationItem.rightBarButtonItems = [logInButton]
        navigationItem.title = "Magpie"
    }
    
    func logInButtonTapped() {
        guard
            let emailRow: EmailRow = form.rowBy(tag: "email"),
            let email = emailRow.value,
            let passwordRow: PasswordRow = form.rowBy(tag: "password"),
            let password = passwordRow.value
            else { return }
        
        APESuperHUD.showOrUpdateHUD(loadingIndicator: .standard, message: "Authenticating...", presentingView: self.view)
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            APESuperHUD.removeHUD(animated: true, presentingView: self.view, completion: nil)

            guard let user = user, error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            print("User: \(user)")
            self.performSegue(withIdentifier: "successLogIn", sender: nil)
        })
    }
}
