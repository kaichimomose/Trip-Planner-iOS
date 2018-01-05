//
//  SignUpViewController.swift
//  Trip-Planner
//
//  Created by Kaichi Momose on 2017/12/06.
//  Copyright © 2017 Kaichi Momose. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var createAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonTapped(_ sender: Any) {
        let username = usernameTextField.text
        let passWord = passwordTextField.text
        if username != "" && passWord != "" {
            Networking().fetch(resource: .signUp(email: username!, password: passWord!)) { (result) in
                DispatchQueue.main.async {
                    guard let user = result as? User else {return}
                    //                    self.user = user
                    User.setCurrent(user)
                    
                    let initialViewController: UIViewController
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    initialViewController = storyboard.instantiateInitialViewController()!
                    
                    //                    initialViewController.user = self.user
                    
                    self.view.window?.rootViewController = initialViewController
                    self.view.window?.makeKeyAndVisible()
                }
            }
            
        } else {
            if username == "" {
                usernameTextField.placeholder = "please set username"
            }
            if passWord == "" {
                passwordTextField.placeholder = "please set password"
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
}
