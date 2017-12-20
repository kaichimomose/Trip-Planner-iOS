//
//  TripViewController.swift
//  Trip-Planner
//
//  Created by Kaichi Momose on 2017/12/20.
//  Copyright © 2017 Kaichi Momose. All rights reserved.
//

import UIKit

class TripTableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension TripTableViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Header function
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripHeader") as! TripHeaderTableViewCell
        cell.checkLabel.layer.cornerRadius = 5
        cell.checkLabel.layer.borderWidth = 2
        cell.checkLabel.layer.borderColor = UIColor.darkGray.cgColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // sets height of header cells
        return 70
    }
    //
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // returns the number of table view rows
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WaypointCell", for: indexPath) as! WaypointTableViewCell
        //        let row = indexPath.row
        cell.backgroundColor = UIColor.darkGray
        return cell
    }
}
