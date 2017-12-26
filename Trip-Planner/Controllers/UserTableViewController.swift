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
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 70
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToUserTableViewController(_ segue: UIStoryboardSegue) {
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

extension UserTableViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Header function
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserHeader") as! UserHeaderTableViewCell
        user = user ?? User.current
        if let user = user {
            cell.usernameLabel.text = user.username
            cell.numberOfTripsLabel.text = String(user.tripsCount)
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripCell", for: indexPath) as! TripTableViewCell
//        let row = indexPath.row
        cell.tripImage.layer.masksToBounds = true
        cell.tripImage.layer.cornerRadius = 2
        cell.tripImage.layer.borderColor = UIColor.darkGray.cgColor
        cell.tripImage.layer.borderWidth = 1
        return cell
    }
    
    
}
