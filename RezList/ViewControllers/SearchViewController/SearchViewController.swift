//
//  SearchViewController.swift
//  RezList
//
//  Created by user 1 on 05/07/2017.
//  Copyright © 2017 ahmad. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import MBProgressHUD
import MapKit
import CoreLocation

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {

    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var tbl: UITableView!
    @IBOutlet weak var map: MKMapView!
    var jsonArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set delegate and data source of tableview to this controller
        
//        map.delegate = self
        
//        let locations = [
//            ["title": "New York, NY",    "latitude": 40.713054, "longitude": -74.007228],
//            ["title": "Los Angeles, CA", "latitude": 34.052238, "longitude": -118.243344],
//            ["title": "Chicago, IL",     "latitude": 41.883229, "longitude": -87.632398]
//        ]
//        
//        for location in locations {
//            let annotation = MKPointAnnotation()
//            annotation.title = location["title"] as? String
//            annotation.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! Double, longitude: location["longitude"] as! Double)
//            map.addAnnotation(annotation)
//        }
//        CLLocationDegrees minLatitude = DBL_MAX;
//        CLLocationDegrees maxLatitude = -DBL_MAX;
//        CLLocationDegrees minLongitude = DBL_MAX;
//        CLLocationDegrees maxLongitude = -DBL_MAX;
        

        
        
        self.tbl.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "searchCell")
        self.tbl.delegate = self
        self.tbl.dataSource = self
        
        self.tbl.delegate = self
        self.tbl.dataSource = self
        
        //end
        
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width

//        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.tabBarController?.tabBar.frame = CGRect(x:0, y:self.topView.frame.size.height,width:screenWidth, height:50)
//        appDelegate.tabBarController?.tabBar.backgroundColor = UIColor.black
//        appDelegate.window?.rootViewController = appDelegate.tabBarController
        
        
        //setting tableview frame
//        let topViewHeight = self.topView.frame.size.height
//        let tabBarHeight  = appDelegate.tabBarController?.tabBar.frame.size.height
//        self.searchTbl.frame = CGRect(x:0, y:topViewHeight+tabBarHeight!+10 ,width:screenWidth, height:self.searchTbl.frame.size.height)

        //end
        // Do any additional setup after loading the view.
        
        getData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tbl.isHidden = false
        self.mapView.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark : UITable View Delegate Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbl.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchTableViewCell
        
//        cell.img.image = UIImage(named: "himage.jpg")
        let propertyObj : NSDictionary = (((jsonArray.object(at: indexPath.row) as AnyObject).value(forKey: "property")as AnyObject)as? NSDictionary)!
        let addressObj : NSDictionary = (((jsonArray.object(at: indexPath.row) as AnyObject).value(forKey: "address")as AnyObject)as? NSDictionary)!
        let photoObj : NSArray = (((jsonArray.object(at: indexPath.row) as AnyObject).value(forKey: "photos")as AnyObject)as? NSArray)!
        
        //parsing data from property object
        let bedRooms : Int = (((propertyObj as AnyObject).value(forKey: "bedrooms")as AnyObject)as? Int)!
        var numBath = Int()
        if let bathRooms : Int = (((propertyObj as AnyObject).value(forKey: "bathrooms")as AnyObject)as? Int){
            numBath = bathRooms
        }
        let area : Int = (((propertyObj as AnyObject).value(forKey: "area")as AnyObject)as? Int)!

        //getting address
        let address : String = (((addressObj as AnyObject).value(forKey: "full")as AnyObject)as? String)!
        
        cell.location.text = address
        cell.beds.text = String(bedRooms)+" Beds"
        cell.baths.text = String(numBath)+" baths"
        cell.area.text = String(area)+" SqFt"
        let uniqueKey : String = (((addressObj as AnyObject).value(forKey: "unit")as AnyObject)as? String)!
        
        // getting photo url from the photo object
        if let photoUrl : String = ((photoObj.object(at: 1) as AnyObject) as? String){
            if let imgData = UserDefaults.standard.object(forKey: uniqueKey) as? Data
            {
                if let image = UIImage(data: imgData as Data)
                {
                    //set image in UIImageView imgSignature
                    cell.img.image = image
                    //remove cache after fetching image data
                }
            }
            else{
                Alamofire.request(photoUrl).responseImage { response in
                    debugPrint(response)
                    print(response.request)
                    print(response.response)
                    debugPrint(response.result)
                    if let image = response.result.value {
                        print("image downloaded: \(image)")
                        cell.img.image = image
                        
                        //                    let strLeagueId = String(self.gameId)
                        let imageData = UIImageJPEGRepresentation(image, 1.0)
                        UserDefaults.standard.set(imageData, forKey: uniqueKey)
                        UserDefaults.standard.synchronize()
                    }
                }
            }

        }
        return cell
    }
    
    @IBAction func mapBtnClicked(_ sender: UIButton) {
        self.tbl.isHidden = true
        self.mapView.isHidden = false
    }
    
    //Mark: getting data for this screen for houses for sale
    
    func getData(){
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.label.text = "Loading"

        let Auth_header : HTTPHeaders = [ "Authorization" : "Basic c2ltcGx5cmV0czpzaW1wbHlyZXRz" ]
        let ApiUrl = "https://api.simplyrets.com/properties?limit=500&lastId=0"
        
        Alamofire.request(ApiUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Auth_header).responseJSON { response in
            debugPrint("response is: ",response)
            MBProgressHUD.hide(for: self.view, animated: true)
            if response.result.isSuccess  && response.response?.statusCode == 200{
                
                if let json : NSArray = response.result.value as? NSArray{
                    print(json)
                    self.jsonArray = json
                    self.tbl.reloadData()
                }
            }
        }
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
