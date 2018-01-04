//
//  AlertHelper.swift
//  Nukon
//
//  Created by Kaichi Momose on 2017/11/12.
//  Copyright © 2017 Kaichi Momose. All rights reserved.
//

import Foundation
import UIKit

protocol AlertPresentable: class {
    func logoutAlert()
}

extension AlertPresentable where Self: UIViewController {
    func selectAlert(){
        let alertVC = UIAlertController(
            title: "Oops!!",
            message: "Please choose at least one sound",
            preferredStyle: .alert
        )
        
        alertVC.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: { (action) in
                    
            })
        )
        
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func logoutAlert(editName: @escaping () -> (), logout: @escaping () -> (), delete: @escaping () -> ()){
        let alertVC = UIAlertController(
            title: "Practice?",
            message: "start practicing",
            preferredStyle: .actionSheet
        )
        
        alertVC.addAction(
            UIAlertAction(
                title: "Cancel",
                style: .cancel,
                handler: { (action) in
                    
            })
        )
        
        alertVC.addAction(
            UIAlertAction(
                title: "Change username",
                style: .default,
                handler: { (action) in
                    editName()
            })
        )
        
        alertVC.addAction(
            UIAlertAction(
                title: "Logout",
                style: .default,
                handler: { (action) in
                 logout()
            })
        )
        
        alertVC.addAction(
            UIAlertAction(
                title: "Delete",
                style: .destructive,
                handler: { (action) in
                 delete()
            })
        )
        
        self.present(alertVC, animated: true, completion: nil)
    }
}
