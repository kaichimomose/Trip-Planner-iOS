//
//  TripViewController.swift
//  Trip-Planner
//
//  Created by Kaichi Momose on 2017/12/20.
//  Copyright © 2017 Kaichi Momose. All rights reserved.
//

import UIKit

class TripTableViewController: UIViewController {
    
    var numberOfCells: Int?
    
    @IBOutlet weak var addWaypointButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        cell.checkButton.layer.cornerRadius = 10
        cell.checkButton.layer.borderWidth = 2
        cell.checkButton.layer.borderColor = UIColor.darkGray.cgColor
        return cell
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "WaypointCell", for: indexPath) as! WaypointTableViewCell
        //        let row = indexPath.row
        cell.backgroundColor = UIColor.darkGray
        return cell
    }
    
    
}
