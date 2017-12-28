//
//  TripViewController.swift
//  Trip-Planner
//
//  Created by Kaichi Momose on 2017/12/20.
//  Copyright © 2017 Kaichi Momose. All rights reserved.
//

import UIKit

class TripTableViewController: UIViewController, UITextFieldDelegate {
    
    var id: Int?
    var numberOfCells: Int?
    var tripName: String = ""
    var completed: Bool = false
    var waypoints: [String] = []
    var trip: Trip?
    
    @IBOutlet weak var addWaypointButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let toolBar = UIToolbar()
    
    var headerCell = TripHeaderTableViewCell()
    var cell = WaypointTableViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let trip = trip {
            
            self.tripName = trip.tripName
            self.completed = trip.completed
            self.numberOfCells = trip.waypoints.count
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        toolBar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneTapped))
        
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        
    }
    
    
    @objc func doneTapped() {
//        if let waypoint = cell.waypointTextField.text {
//            self.waypoints.append(waypoint)
//        }
        tableView.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func addWaypointButtonTapped(_ sender: Any) {
        if self.numberOfCells != nil {
            self.numberOfCells! += 1
        } else {
            self.numberOfCells = 0
            self.numberOfCells! += 1
        }
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "save" {
            
            for i in 0...tableView.visibleCells.count - 1{
                let indexpathForWaypoints = NSIndexPath(row: i, section: 0)
                let waypointTableViewCell = tableView.cellForRow(at: indexpathForWaypoints as IndexPath)! as! WaypointTableViewCell
                let waypoint = waypointTableViewCell.waypointTextField.text
                self.waypoints.append(waypoint!)
            }
            
            if trip != nil {
                let newTrip = self.headerCell.tripNameTextField.text ?? ""
                let newCompleted = self.headerCell.completed
                
                Networking().fetch(resource: .editTrip(id: (trip?.id)!, oldTrip: self.tripName, newTrip: newTrip, completed: newCompleted, waypoints: self.waypoints)) { (result) in
                    DispatchQueue.main.async {
                        
                    }
                }
                
            } else {
                self.tripName = self.headerCell.tripNameTextField.text ?? ""
                self.completed = self.headerCell.completed
            
                Networking().fetch(resource: .postTrip(id: id!, tripName: self.tripName, completed: self.completed, waypoints: self.waypoints)) { (result) in
                    DispatchQueue.main.async {

                    }
                }
            }
        }
    }
    

}

extension TripTableViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Header function
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerCell = tableView.dequeueReusableCell(withIdentifier: "TripHeader") as! TripHeaderTableViewCell
        
        if let trip = trip {
            headerCell.trip = trip
        }
        
        headerCell.checkButton.layer.cornerRadius = 10
        headerCell.checkButton.layer.borderWidth = 2
        headerCell.checkButton.layer.borderColor = UIColor.darkGray.cgColor
        
        headerCell.tripNameTextField.inputAccessoryView = toolBar
        
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // sets height of header cells
        return 80
    }
    //
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // returns the number of table view rows
        let numberOfCells = self.numberOfCells ?? 0
        return numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: "WaypointCell", for: indexPath) as! WaypointTableViewCell
        let row = indexPath.row
        
        if let trip = trip {
            if row < trip.waypoints.count {
                cell.waypointTextField.text = trip.waypoints[row]
            }
        }
        
        cell.backgroundColor = UIColor.darkGray
        
        cell.waypointTextField.inputAccessoryView = toolBar
        
        return cell
    }
    
    
}
