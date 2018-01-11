//
//  SettingViewController.swift
//  Trip-Planner
//
//  Created by Kaichi Momose on 2018/01/04.
//  Copyright © 2018 Kaichi Momose. All rights reserved.
//

import UIKit
import KeychainSwift

class SettingViewController: UIViewController, UITextFieldDelegate {
    
    var user: User?
    let keychain = KeychainSwift()
    
    @IBOutlet weak var newUsernameTextField: UITextField!
    @IBOutlet weak var setButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func serButtonTapped(_ sender: Any) {
        editName()
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        deleteUser()
        
        // delete username and password from keychain
        keychain.delete("username")
        keychain.delete("password")
        
        // back to login window
        backToLoginWindow()
        
    }
    @IBAction func logoutButtonTapped(_ sender: Any) {
        backToLoginWindow()
    }
    
    func backToLoginWindow() {
        // back to login window
        let initialViewController: UIViewController
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        initialViewController = storyboard.instantiateInitialViewController()!
        self.view.window?.rootViewController = initialViewController
        self.view.window?.makeKeyAndVisible()
    }
    
    func editName() {
        let newUsername = newUsernameTextField.text
        if newUsername != "" {
            Networking().fetch(resource: .editProfile(username: (user?.username)!, newUsername: newUsername!)) { (result) in
                DispatchQueue.main.async {
                    guard let user = result as? User else {return}
                    
                    //set username in keychain
                    self.keychain.set(newUsername!, forKey: "username")
                    
                    User.setCurrent(user, writeToUserDefaults: true)
                }
            }
        } else {
            newUsernameTextField.placeholder = "Type new username!!"
        }
    }
    
    func deleteUser() {
        Networking().fetch(resource: .deleteAccount(id: (user?.id)!)) { (result) in
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
