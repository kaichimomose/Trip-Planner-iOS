//
//  LoginViewController.swift
//  Trip-Planner
//
//  Created by Kaichi Momose on 2017/12/06.
//  Copyright © 2017 Kaichi Momose. All rights reserved.
//

import UIKit
import KeychainSwift

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var warningLabel: UILabel!
    
    var user: User!
    let keychain = KeychainSwift()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.warningLabel.layer.cornerRadius = 3
        self.warningLabel.layer.borderColor = UIColor.red.cgColor
        self.warningLabel.layer.borderWidth = 1
        self.warningLabel.isHidden = true
        
        if let username = self.keychain.get("username") {
            userNameTextField.text = username
        }
        if let password = self.keychain.get("password") {
            passWordTextField.text = password
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        let username = userNameTextField.text
        let passWord = passWordTextField.text
        if username != "" && passWord != "" {
            Networking().fetch(resource: .login(email: username!, password: passWord!)) { (result) in
                DispatchQueue.main.async {
                    guard let user = result as? User else {
                        return
                    }
                    print("result exists")
//                    self.user = user
                    
                    //set username and password in keychain
                    self.keychain.set(username!, forKey: "username")
                    self.keychain.set(passWord!, forKey: "password")
                    
                    //save userdefault
                    User.setCurrent(user, writeToUserDefaults: true)
                    
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
                userNameTextField.placeholder = "please fill out username/email"
            }
            if passWord == "" {
                passWordTextField.placeholder = "please fill out password"
            }
        }
    
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
