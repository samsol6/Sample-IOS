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
    
    @IBOutlet weak var topView: UIView!
    var optionsArr = NSMutableArray()
    var adminOptionsArray = NSMutableArray()
    var iconsArray = NSMutableArray()
    var adminIconsArray = NSMutableArray()
    
    var isAdmin = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        if let u = UserDefaults.standard.string(forKey: "role") {
            if(u == "admin"){
                isAdmin = true
            }
            else{
                isAdmin = false
            }
        }
        
        //adding elements to the array
        
        //new editing
       // let screenSize: CGRect = UIScreen.main.bounds
       //let screenWidth = screenSize.width
        
       // let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
       // appDelegate.tabBarController?.tabBar.frame = CGRect(x:0, y:self.topView.frame.size.height,width:screenWidth, height:50)
       // appDelegate.tabBarController?.tabBar.backgroundColor = UIColor.black
       // appDelegate.window?.rootViewController = appDelegate.tabBarController
        
//        let tabBarHeight  = appDelegate.tabBarController?.tabBar.frame.size.height
        
        //end
        
        
        optionsArr = ["Profile", "Explore", "Flat Fee Calculator", "Notifications","Settings", "Log out"]
        adminOptionsArray = ["Profile", "Explore", "Flat Fee Calculator", "Notifications", "Settings", "Log out", "User List"]
//        iconsArray = ["contact.png", "search_white.png", "white_cal.png", "white_bell.png" , "logout.png", "white_setting.png"]
        iconsArray = ["contactWhiteNew.png", "search_white.png", "white_calNew.png", "white_bellNew.png" , "white_settingNew.png", "powerNew.png"]
        
        adminIconsArray = ["contact.png", "search_white.png", "white_calNew.png", "white_bellNew.png" , "white_settingNew.png", "powerNew.png" , "group.png"]
        
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
        if(isAdmin){
            return adminOptionsArray.count
        }
        else{
            return optionsArr.count
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbl.dequeueReusableCell(withIdentifier: "DashboardCell", for: indexPath) as! DashboardTableViewCell
        cell.backgroundColor = UIColor(red:0.18, green:0.18, blue:0.18, alpha:1.0)
        if(isAdmin){
            cell.img.image = UIImage(named: (adminIconsArray[indexPath.row] as? String)!)
            cell.option.text = adminOptionsArray.object(at: indexPath.row) as? String
        }
        else{
            cell.img.image = UIImage(named: (iconsArray[indexPath.row] as? String)!)
            cell.option.text = optionsArr.object(at: indexPath.row) as? String
        }
        
        cell.option.textColor = UIColor.white
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 2){
            
            let vc = FeeCalculatorViewController(
                nibName: "FeeCalculatorViewController",
                bundle: nil)
            self.present(vc, animated: true, completion: nil)
        }
        if(indexPath.row == 6){
            let vc = EmailUserListViewController(
                nibName: "EmailUserListViewController",
                bundle: nil)
            self.present(vc, animated: true, completion: nil)
        }
        
        if(isAdmin){
            if(indexPath.row == 5){
                let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.tabBarController?.selectedIndex = 0
                let homeViewController = HomeViewController()
                appDelegate.window?.rootViewController = homeViewController
                
                UserDefaults.standard.set("not", forKey: "isLogin")
                UserDefaults.standard.synchronize()
            }
        }
        else{
            if(indexPath.row == 5){
                let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.tabBarController?.selectedIndex = 0
                
                
                UserDefaults.standard.set("not", forKey: "isLogin")
                UserDefaults.standard.synchronize()
                
                let homeViewController = HomeViewController()
                appDelegate.window?.rootViewController = homeViewController
                
            }
        }
        
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
