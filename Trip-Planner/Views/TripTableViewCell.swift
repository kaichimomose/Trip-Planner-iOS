//
//  TripTableViewCell.swift
//  Trip-Planner
//
//  Created by Kaichi Momose on 2017/12/16.
//  Copyright © 2017 Kaichi Momose. All rights reserved.
//

import UIKit

class TripTableViewCell: UITableViewCell {

    @IBOutlet weak var tripImage: UIImageView!
    @IBOutlet weak var tripNameLabel: UILabel!
    @IBOutlet weak var tripDateLabel: UILabel!
    @IBOutlet weak var checkLabel: UILabel!
    
    var trip: Trip? {
        didSet {
            tripNameLabel.text = trip?.tripName
            
        }
    }
}
