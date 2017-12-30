//
//  UserTableViewController.swift
//  Trip-Planner
//
//  Created by Kaichi Momose on 2017/12/16.
//  Copyright © 2017 Kaichi Momose. All rights reserved.
//

import UIKit

class UserTableViewController: UIViewController {
    
    var user: User?
    var trips = [Trip]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 70
        user = user ?? User.current
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Networking().fetch(resource: .myTrip(id: (user?.id)!)) { (result) in
            DispatchQueue.main.async {
                guard let trips = result as? [Trip] else {return}
                
                self.trips = trips

                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToUserTableViewController(_ segue: UIStoryboardSegue) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "trip" {
            let tripTVC = segue.destination as! TripTableViewController
            tripTVC.id = user?.id
        }
    }
}

extension UserTableViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Header function
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserHeader") as! UserHeaderTableViewCell

        if let user = user {
            cell.usernameLabel.text = user.username
            cell.numberOfTripsLabel.text = String(describing: self.trips.count)
        } else {
            cell.usernameLabel.text = "No username"
            cell.numberOfTripsLabel.text = String(0)
        }
        
        cell.userImage.layer.masksToBounds = true
        cell.userImage.layer.cornerRadius = cell.userImage.frame.width/2
        cell.userImage.layer.borderWidth = 2
        cell.userImage.layer.borderColor = UIColor.lightGray.cgColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // sets height of header cells
        return 100
    }
    //
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // returns the number of table view rows
        return trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripCell", for: indexPath) as! TripTableViewCell
        let row = indexPath.row
        cell.tripImage.layer.masksToBounds = true
        cell.tripImage.layer.cornerRadius = 2
        cell.tripImage.layer.borderColor = UIColor.darkGray.cgColor
        cell.tripImage.layer.borderWidth = 1
        
        cell.checkLabel.layer.cornerRadius = 10
        cell.checkLabel.layer.borderColor = UIColor.darkGray.cgColor
        cell.checkLabel.layer.borderWidth = 2
        
        cell.trip = self.trips[row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        
        let tripTVC = storyboard?.instantiateViewController(withIdentifier: "TripTableViewController") as! TripTableViewController
        
        tripTVC.trip = self.trips[row]
        
        self.navigationController?.pushViewController(tripTVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let row = indexPath.row
        
        if editingStyle == .delete {
            Networking().fetch(resource: .deleteTrip(id: (user?.id)!, tripName: self.trips[row].tripName)) { (result) in
                DispatchQueue.main.async {
                    guard let trips = result as? [Trip] else {return}
                    
                    self.trips = trips
                    
                    self.tableView.reloadData()
                }
            }
        }
    }
}
