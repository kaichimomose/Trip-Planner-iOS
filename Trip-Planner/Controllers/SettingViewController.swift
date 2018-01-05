//
//  SettingViewController.swift
//  Trip-Planner
//
//  Created by Kaichi Momose on 2018/01/04.
//  Copyright © 2018 Kaichi Momose. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITextFieldDelegate {
    
    var user: User?
    
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
        let initialViewController: UIViewController
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        initialViewController = storyboard.instantiateInitialViewController()!
        
        //                    initialViewController.user = self.user
        
        self.view.window?.rootViewController = initialViewController
        self.view.window?.makeKeyAndVisible()
        
    }
    
    func editName() {
        let newUsername = newUsernameTextField.text
        if newUsername != "" {
            Networking().fetch(resource: .editProfile(username: (user?.username)!, newUsername: newUsername!)) { (result) in
                DispatchQueue.main.async {
                    guard let user = result as? User else {return}
                    //                    self.user = user
                    User.setCurrent(user)
                }
            }
        } else {
            newUsernameTextField.placeholder = "Type new username!!"
        }
    }
    
    func deleteUser() {
        Networking().fetch(resource: .deleteAccount(id: (user?.id)!)) { (result) in
            DispatchQueue.main.async {
                let initialViewController: UIViewController
                let storyboard = UIStoryboard(name: "Login", bundle: nil)
                initialViewController = storyboard.instantiateInitialViewController()!
                
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
