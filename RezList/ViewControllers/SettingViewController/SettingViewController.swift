//
//  SettingViewController.swift
//  RezList
//
//  Created by user 1 on 07/07/2017.
//  Copyright © 2017 ahmad. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var settingTbl: UITableView!
    
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var notifcation: UIButton!
    
    @IBOutlet weak var support: UIButton!
    @IBOutlet weak var privacy: UIButton!
    @IBOutlet weak var terms: UIButton!
    @IBOutlet weak var contact: UIButton!
    @IBOutlet weak var logout: UIButton!
    
    var optionsArr = NSMutableArray()
    var imgArr = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.mainView.backgroundColor = UIColor(red:0.21, green:0.21, blue:0.21, alpha:1.0)
        self.middleView.backgroundColor = UIColor(red:0.25, green:0.25, blue:0.25, alpha:1.0)
        
        notifcation.setTitleColor(UIColor(red:0.68, green:0.68, blue:0.68, alpha:1.0), for: .normal)
        support.setTitleColor(UIColor(red:0.68, green:0.68, blue:0.68, alpha:1.0), for: .normal)
        privacy.setTitleColor(UIColor(red:0.68, green:0.68, blue:0.68, alpha:1.0), for: .normal)
        terms.setTitleColor(UIColor(red:0.68, green:0.68, blue:0.68, alpha:1.0), for: .normal)
        contact.setTitleColor(UIColor(red:0.68, green:0.68, blue:0.68, alpha:1.0), for: .normal)
        logout.setTitleColor(UIColor(red:0.68, green:0.68, blue:0.68, alpha:1.0), for: .normal)
        
        
//        self.settingTbl.register(UINib(nibName: "SettingTableViewCell", bundle: nil), forCellReuseIdentifier: "settingCell")
//        self.settingTbl.register(UINib(nibName: "SettingTableViewCell2", bundle: nil), forCellReuseIdentifier: "SettingCell2")
//        self.settingTbl.delegate = self
//        self.settingTbl.dataSource = self
//        self.settingTbl.separatorColor = UIColor(red:0.36, green:0.36, blue:0.36, alpha:1.0)
        
        //initialize arrays
        optionsArr = ["Notifications", "Support", "Privacy", "Terms", "Contact", "Logout"]
        imgArr = ["icon-bell.png", "clock_icon.png", "lock_small.png", "paper.png", "head_set.png", "logout.png"]
        //lock_small.png
        //paper.png
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark: UITableView Delegate Functions

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionsArr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingTbl.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! SettingTableViewCell
        let cell2 = settingTbl.dequeueReusableCell(withIdentifier: "SettingCell2", for: indexPath) as! SettingTableViewCell2
        
        
        cell.backgroundColor = UIColor(red:0.21, green:0.21, blue:0.21, alpha:1.0)
        cell.img.image = UIImage(named: (imgArr[indexPath.row] as? String)!)
        cell.option.text = optionsArr.object(at: indexPath.row) as? String
        cell.option.textColor = UIColor(red:0.61, green:0.61, blue:0.61, alpha:1.0)
        
        
        if(indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4){
            cell2.backgroundColor = UIColor(red:0.25, green:0.25, blue:0.25, alpha:1.0)
            cell2.img.image = UIImage(named: (imgArr[indexPath.row] as? String)!)
            cell2.option.text = optionsArr.object(at: indexPath.row) as? String
            cell2.option.textColor = UIColor(red:0.61, green:0.61, blue:0.61, alpha:1.0)
//            let imgX = cell.img.frame.origin.x
//            let changedImgX = imgX + 40
//            cell.img.frame = CGRect(x: changedImgX, y: cell.img.frame.origin.y, width:  cell.img.frame.size.width, height: cell.img.frame.size.height)
//            let optionX = cell.option.frame.origin.x
//            let changedOptionX = optionX + 40
//            cell.option.frame = CGRect(x: changedOptionX, y: cell.option.frame.origin.y, width: cell.option.frame.size.width-21, height: cell.option.frame.size.height)
            
        }
        
      
        
        return cell
    }

    
    //end...

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
