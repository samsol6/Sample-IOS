//
//  SearchViewController.swift
//  RezList
//
//  Created by user 1 on 05/07/2017.
//  Copyright © 2017 ahmad. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var searchTbl: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set delegate and data source of tableview to this controller
//        self.searchTbl.register(SearchTableViewCell.self, forCellReuseIdentifier: "searchCell")
        self.searchTbl.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "searchCell")
        self.searchTbl.delegate = self
        self.searchTbl.dataSource = self
        
        //end
        
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width

        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.tabBarController?.tabBar.frame = CGRect(x:0, y:self.topView.frame.size.height,width:screenWidth, height:50)
        appDelegate.tabBarController?.tabBar.backgroundColor = UIColor.black
        appDelegate.window?.rootViewController = appDelegate.tabBarController
        
        
        //setting tableview frame
        let topViewHeight = self.topView.frame.size.height
        let tabBarHeight  = appDelegate.tabBarController?.tabBar.frame.size.height
        self.searchTbl.frame = CGRect(x:0, y:topViewHeight+tabBarHeight!+10 ,width:screenWidth, height:self.searchTbl.frame.size.height)

        //end
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.searchTbl.isHidden = false
        self.mapView.isHidden = true
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
        return 200
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTbl.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchTableViewCell
        
        cell.img.image = UIImage(named: "himage.jpg")
     
        return cell
    }
    
    @IBAction func mapBtnClicked(_ sender: UIButton) {
        self.searchTbl.isHidden = true
        self.mapView.isHidden = false
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
