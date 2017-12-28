//
//  TripHeaderTableViewCell.swift
//  Trip-Planner
//
//  Created by Kaichi Momose on 2017/12/20.
//  Copyright © 2017 Kaichi Momose. All rights reserved.
//

import UIKit

class TripHeaderTableViewCell: UITableViewCell {
    
    var completed: Bool = false
    
    @IBOutlet weak var tripNameTextField: UITextField!
    @IBOutlet weak var tripDateLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    @IBAction func checkButtonTapped(_ sender: Any) {
        if completed {
            completed = false
            checkButton.setTitle("", for: .normal)
        } else {
            completed = true
            checkButton.setTitle("✔️", for: .normal)
        }
    }
    
    var trip: Trip? {
        didSet {
            tripNameTextField.text = trip?.tripName
            completed = trip?.completed ?? false
            if completed {
                checkButton.setTitle("✔️", for: .normal)
            } else {
                checkButton.setTitle("", for: .normal)
            }
        }
    }
    
//    func returnTextOfTripNameTextField() -> String
//    {
//        print(tripNameTextField.text ?? "")
//        return tripNameTextField.text!
//    }
    
}
