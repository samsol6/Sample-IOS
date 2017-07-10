//
//  NotificationViewController.swift
//  RezList
//
//  Created by user 1 on 07/07/2017.
//  Copyright © 2017 ahmad. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var notificationTbl: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.notificationTbl.register(UINib(nibName: "NotificationTableViewCell", bundle: nil), forCellReuseIdentifier: "NotificationCell")
        self.notificationTbl.delegate = self
        self.notificationTbl.dataSource = self
        self.notificationTbl.separatorColor = UIColor(red:0.77, green:0.78, blue:0.80, alpha:1.0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark: - UITableView Delegate functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notificationTbl.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationTableViewCell
        
        
        cell.backgroundColor = UIColor(red:0.97, green:0.98, blue:1.00, alpha:1.0)
        
        cell.userImg.image = UIImage(named: "agent.png")
        
        cell.userName.text = "John Smith"
        cell.userName.textColor = UIColor(red:0.49, green:0.64, blue:0.77, alpha:1.0)
        
        cell.userSearch.text = "Looking for a Property"
        cell.userSearch.textColor = UIColor(red:0.72, green:0.73, blue:0.75, alpha:1.0)
        
        cell.userSearchTime.text = "3 min ago"
        cell.userSearchTime.textColor = UIColor(red:0.76, green:0.78, blue:0.79, alpha:1.0)
        
        return cell
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
