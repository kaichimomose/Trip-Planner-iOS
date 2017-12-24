//
//  RecentTableViewController.swift
//  Trip-Planner
//
//  Created by Kaichi Momose on 2017/12/23.
//  Copyright © 2017 Kaichi Momose. All rights reserved.
//

import UIKit

class RecentTripTableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension FriendTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friend") as! RecentTripTableViewCell
        return cell
    }
    
    
}
