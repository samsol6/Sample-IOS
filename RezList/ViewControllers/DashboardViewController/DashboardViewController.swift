//
//  DashboardViewController.swift
//  RezList
//
//  Created by user 1 on 06/07/2017.
//  Copyright © 2017 ahmad. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tbl: UITableView!
    var optionsArr = NSMutableArray()
    var iconsArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //adding elements to the array
        optionsArr = ["Profile", "Explore", "Flat Fee Calculator", "Notifications", "Settings"]
        iconsArray = ["contact.png", "search_white.png", "white_cal.png", "white_bell.png" , "white_setting.png"]
        
        //end
        self.tbl.register(UINib(nibName: "DashboardTableViewCell", bundle: nil), forCellReuseIdentifier: "DashboardCell")
        self.tbl.delegate = self
        self.tbl.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark : UITable View Delegate Functions

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbl.dequeueReusableCell(withIdentifier: "DashboardCell", for: indexPath) as! DashboardTableViewCell
        cell.backgroundColor = UIColor(red:0.18, green:0.18, blue:0.18, alpha:1.0)
//        UIImage(named: MyLeagueNameList[indexPath.row] as! String)

        cell.img.image = UIImage(named: (iconsArray[indexPath.row] as? String)!)
        cell.option.text = optionsArr.object(at: indexPath.row) as? String
        cell.option.textColor = UIColor.white
        
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
