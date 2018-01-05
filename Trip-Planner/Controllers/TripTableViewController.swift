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
    var extraCells: Int = 0
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
            self.waypoints = trip.waypoints
//            self.numberOfCells = self.waypoints.count
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
        if headerCell.tripNameTextField.text != "" {
            self.tripName = headerCell.tripNameTextField.text ?? "No Name"
        }
        tableView.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let pointInTable = textField.superview?.convert(textField.frame, to: tableView)
        if (pointInTable?.minY)! > tableView.frame.height - 250 {
            tableView.setContentOffset(CGPoint.init(x: 0, y: 250), animated: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        tableView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
    }
    
    @IBAction func addWaypointButtonTapped(_ sender: Any) {
//        if self.numberOfCells != nil {
//            self.numberOfCells! += 1
//        } else {
//            self.numberOfCells = 0
//            self.numberOfCells! += 1
//        }
        if self.waypoints != [] {
            self.addWaypoint()
        }
        
        
        self.extraCells += 1
        self.waypoints.append("")
        self.tableView.reloadData()
    }
    
    func addWaypoint() {
        self.waypoints = []
        
        for i in 0...tableView.visibleCells.count - 1{
            let indexpathForWaypoints = NSIndexPath(row: i, section: 0)
            let waypointTableViewCell = tableView.cellForRow(at: indexpathForWaypoints as IndexPath)! as! WaypointTableViewCell
            let waypoint = waypointTableViewCell.waypointTextField.text
            self.waypoints.append(waypoint!)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "save" {
            if self.waypoints == [] || self.headerCell.tripNameTextField.text == ""{
                return
            } else {
                self.addWaypoint()
            }
            
            if trip != nil {
                let newTrip = self.headerCell.tripNameTextField.text ?? ""
                let newCompleted = self.headerCell.completed
                
                Networking().fetch(resource: .editTrip(id: (trip?.id)!, oldTrip: (trip?.tripName)!, newTrip: newTrip, completed: newCompleted, waypoints: self.waypoints)) { (result) in
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
        } else {
            headerCell.tripNameTextField.text = self.tripName
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
        let numberOfCells = self.waypoints.count
        return numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: "WaypointCell", for: indexPath) as! WaypointTableViewCell
        let row = indexPath.row
        
//        if trip != nil {
//            if row < self.waypoints.count {
//                cell.waypointTextField.text = self.waypoints[row]
//            }
//        }
        
        cell.waypointTextField.text = self.waypoints[row]
        
        cell.waypointTextField.inputAccessoryView = toolBar
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let row = indexPath.row
        
        if editingStyle == .delete {
            self.waypoints.remove(at: row)
            tableView.reloadData()
        }
    }
}
