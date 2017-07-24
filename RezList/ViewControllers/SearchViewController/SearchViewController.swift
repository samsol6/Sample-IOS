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

class SearchViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {

    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tbl: UITableView!
    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var qrCodeLbl: UILabel!
    
    @IBOutlet weak var mapBtn: UIButton!
    @IBOutlet weak var menuBtn: UIButton!
    
    @IBOutlet weak var filterSearchLbl: UILabel!
    @IBOutlet weak var crossBtn: UIButton!
    
    var jsonArray = NSArray()
    var searchArray = NSMutableArray()
    var myLocations = NSMutableArray()
    
    var addressArray = NSMutableArray()
    
    var searchActive = Bool()
    var qrCodeActive = Bool()
    
    
    //new searching on the basis of the min price and max price
    var minPrice = Int()
    var maxPrice = Int()
    var bedFilter = Int()
    var areaFilter = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set delegate and data source of tableview to this controller
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.showInfo(notification:)) , name: NSNotification.Name(rawValue: "qrCodeInfo"), object: nil)
        
        self.qrCodeLbl.isHidden = true
         self.searchField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        self.searchField.delegate = self
        //correct code...*******************
//        let annotation = MKPointAnnotation()
//        
//        annotation.coordinate = CLLocationCoordinate2D(latitude: 11.12, longitude: 12.11)
//        map.addAnnotation(annotation)
//        
//        let locations = [
//            ["title": "New York, NY",    "latitude": 40.713054, "longitude": -74.007228],
//            ["title": "Los Angeles, CA", "latitude": 34.052238, "longitude": -118.243344],
//            ["title": "Chicago, IL",     "latitude": 41.883229, "longitude": -87.632398],
//            ["title": "Chicago, IL",     "latitude": 45.883229, "longitude": -86.632398]
//        ]
//        
//        for location in locations {
//            let annotation = MKPointAnnotation()
//            annotation.title = location["title"] as? String
//            annotation.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! Double, longitude: location["longitude"] as! Double)
//            map.addAnnotation(annotation)
//        }
//        
//        map.showAnnotations(map.annotations, animated: true)
        //end correct code...*******************************
        
//        self.tbl.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "searchCell")
//        self.tbl.register(UINib(nibName: "SearchTableViewCell~ipad", bundle: nil), forCellReuseIdentifier: "searchCell")
        self.tbl.delegate = self
        self.tbl.dataSource = self
        
        self.tbl.delegate = self
        self.tbl.dataSource = self
        
        //end
        
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom
        
        // 2. check the idiom
            
        if (deviceIdiom == .pad)
        {
            self.tbl.register(UINib(nibName: "SearchTableViewCell~ipad", bundle: nil), forCellReuseIdentifier: "searchCell")
            let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.tabBarController?.tabBar.frame = CGRect(x:0, y:self.topView.frame.size.height,width:screenWidth, height:100)
            appDelegate.tabBarController?.tabBar.backgroundColor = UIColor.black
            appDelegate.window?.rootViewController = appDelegate.tabBarController

        }
        else if(deviceIdiom == .phone )
        {
            self.tbl.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "searchCell")

            let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.tabBarController?.tabBar.frame = CGRect(x:0, y:self.topView.frame.size.height,width:screenWidth, height:50)
            appDelegate.tabBarController?.tabBar.backgroundColor = UIColor.black
            appDelegate.window?.rootViewController = appDelegate.tabBarController
        }
        
            //correct code **********************
//        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.tabBarController?.tabBar.frame = CGRect(x:0, y:self.topView.frame.size.height,width:screenWidth, height:50)
//        appDelegate.tabBarController?.tabBar.backgroundColor = UIColor.black
//        appDelegate.window?.rootViewController = appDelegate.tabBarController

            
            //end correct code... ******************
            
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
        
        self.searchField.layer.borderColor = UIColor(red:1.00, green:0.77, blue:0.77, alpha:1.0).cgColor
        self.searchField.layer.borderWidth = 0.8
        getData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
         let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.tabBarController?.tabBar.isHidden = false
        
        self.crossBtn.isHidden = true
        self.filterSearchLbl.isHidden = true
        
        if(self.minPrice != 0 || self.maxPrice != 0){
            
//            self.mapBtn.isUserInteractionEnabled = true
//            self.searchField.isUserInteractionEnabled = true
//            self.menuBtn.isUserInteractionEnabled = true
            
            self.mapBtn.isHidden = true
            self.searchField.isHidden = true
            self.menuBtn.isHidden = true

            self.filterSearchLbl.isHidden = false
            self.crossBtn.isHidden = false
            self.filterSearchLbl.transform = CGAffineTransform( translationX: 0.0, y: 62.0 )
            
//            self.mapBtn.transform = CGAffineTransform( translationX: 0.0, y: 62.0 )
//            self.searchField.transform = CGAffineTransform( translationX: 0.0, y: 62.0 )
//            self.menuBtn.transform = CGAffineTransform( translationX: 0.0, y: 62.0 )
        }
        
        if(qrCodeActive){
            self.tbl.isHidden = true
            self.qrCodeLbl.isHidden = false
            self.qrCodeActive = false
        }
        else{
            self.tbl.isHidden = false
            self.qrCodeLbl.isHidden = true
        }
        self.mapView.isHidden = true
        self.searchActive = false

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark: Notification Center
    
    func showInfo(notification:Notification) -> Void {
        self.qrCodeActive = true
        self.qrCodeLbl.isHidden = false
        self.tbl.isHidden = true
        let userobject :AnyObject = notification.userInfo as AnyObject
        guard let searchString = notification.userInfo?["info"] as? String else { return }
        self.qrCodeLbl.text = searchString
    }
    //end
    //Mark : UITable View Delegate Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive){
            return self.searchArray.count
        }
        else{
            return jsonArray.count
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(UIDevice.current.userInterfaceIdiom == .phone){
            return 200
        }
        else{
            return 400
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbl.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchTableViewCell
        
        if(searchActive){
            let propertyObj : NSDictionary = (((self.searchArray.object(at: indexPath.row) as AnyObject).value(forKey: "property")as AnyObject)as? NSDictionary)!
            let addressObj : NSDictionary = (((self.searchArray.object(at: indexPath.row) as AnyObject).value(forKey: "address")as AnyObject)as? NSDictionary)!
            let photoObj : NSArray = (((self.searchArray.object(at: indexPath.row) as AnyObject).value(forKey: "photos")as AnyObject)as? NSArray)!
            let geoLocationObj : NSDictionary = (((self.searchArray.object(at: indexPath.row) as AnyObject).value(forKey: "geo")as AnyObject)as? NSDictionary)!
            
            //parsing data from property object
            let Price : Int = ((self.searchArray.object(at: indexPath.row) as AnyObject).value(forKey: "listPrice")as! Int)
            cell.price.text = "$"+String(Price)
            
            let bedRooms : Int = (((propertyObj as AnyObject).value(forKey: "bedrooms")as AnyObject)as? Int)!
            var numBath = Int()
            if let bathRooms : Int = (((propertyObj as AnyObject).value(forKey: "bathsFull")as AnyObject)as? Int){
                numBath = bathRooms
            }
            let area : Int = (((propertyObj as AnyObject).value(forKey: "area")as AnyObject)as? Int)!
            
            //getting address
            let address : String = (((addressObj as AnyObject).value(forKey: "full")as AnyObject)as? String)!
            
            cell.location.text = address
            cell.beds.text = String(bedRooms)
            cell.baths.text = String(numBath)
            cell.area.text = String(area)
            
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
        }
        else{
            let propertyObj : NSDictionary = (((jsonArray.object(at: indexPath.row) as AnyObject).value(forKey: "property")as AnyObject)as? NSDictionary)!
            let addressObj : NSDictionary = (((jsonArray.object(at: indexPath.row) as AnyObject).value(forKey: "address")as AnyObject)as? NSDictionary)!
            let photoObj : NSArray = (((jsonArray.object(at: indexPath.row) as AnyObject).value(forKey: "photos")as AnyObject)as? NSArray)!
            let geoLocationObj : NSDictionary = (((jsonArray.object(at: indexPath.row) as AnyObject).value(forKey: "geo")as AnyObject)as? NSDictionary)!
            
            //parsing data from property object
            let bedRooms : Int = (((propertyObj as AnyObject).value(forKey: "bedrooms")as AnyObject)as? Int)!
            var numBath = Int()
            if let bathRooms : Int = (((propertyObj as AnyObject).value(forKey: "bathsFull")as AnyObject)as? Int){
                numBath = bathRooms
            }
            
             let Price : Int = ((jsonArray.object(at: indexPath.row) as AnyObject).value(forKey: "listPrice")as! Int)
            cell.price.text = "$"+String(Price)
            
            let area : Int = (((propertyObj as AnyObject).value(forKey: "area")as AnyObject)as? Int)!

            //getting address
            let address : String = (((addressObj as AnyObject).value(forKey: "full")as AnyObject)as? String)!
            
            cell.location.text = address
            cell.beds.text = String(bedRooms)
            cell.baths.text = String(numBath)
            cell.area.text = String(area)
            
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
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(searchActive){
            let vc = HotelDetailViewController(
                nibName: "HotelDetailViewController",
                bundle: nil)
            let propertyObj : NSDictionary = (self.searchArray.object(at: indexPath.row) as? NSDictionary)!
            vc.dict = propertyObj
            self.present(vc, animated: true, completion: nil)
        }
        else{
            let vc = HotelDetailViewController(
                nibName: "HotelDetailViewController",
                bundle: nil)
            let propertyObj : NSDictionary = (self.jsonArray.object(at: indexPath.row) as? NSDictionary)!
            vc.dict = propertyObj
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func mapBtnClicked(_ sender: UIButton) {
        self.tbl.isHidden = true
        self.mapView.isHidden = false
        
        var count = 0
        while ( count < myLocations.count){
            if let location : NSMutableDictionary = myLocations.object(at: count) as? NSMutableDictionary{
                let annotation = MKPointAnnotation()
                let title : String = (location.value(forKey: "title") as? String)!
                let lat : Double = (location.value(forKey: "latitude") as? Double)!
                let long : Double = (location.value(forKey: "longitude") as? Double)!
                annotation.title = title
                annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                map.addAnnotation(annotation)
                
                count += 1
            }
        }
        map.showAnnotations(map.annotations, animated: true)
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
                    
                    self.getGeoLocation()
                    
                    if(self.minPrice != 0 || self.maxPrice != 0){
                        self.getDataOnPrice()
                    }
                    self.tbl.reloadData()
                }
            }
        }
    }
    
    func getGeoLocation(){
        //making array of geoLocation Coordinates
        self.addressArray.removeAllObjects()
        var count = 0
        while (count < jsonArray.count){
            let addressObj : NSDictionary = (((jsonArray.object(at: count) as AnyObject).value(forKey: "address")as AnyObject)as? NSDictionary)!
            let geoLocationObj : NSDictionary = (((jsonArray.object(at: count) as AnyObject).value(forKey: "geo")as AnyObject)as? NSDictionary)!
            
            
            let locations = [
                ["title": "New York, NY",    "latitude": 40.713054, "longitude": -74.007228],
                ["title": "Los Angeles, CA", "latitude": 34.052238, "longitude": -118.243344],
                ["title": "Chicago, IL",     "latitude": 41.883229, "longitude": -87.632398],
                ["title": "Chicago, IL",     "latitude": 45.883229, "longitude": -86.632398]
            ]
            
            let address : String = (((addressObj as AnyObject).value(forKey: "full")as AnyObject)as? String)!
            
            self.addressArray.add(address)
            var obj = NSMutableDictionary()
            var latitude = Double()
            var longitude = Double()
            if let lat: Double = (((geoLocationObj as AnyObject).value(forKey: "lat")as AnyObject)as? Double)!{
                latitude = lat
            }
            if let long: Double = (((geoLocationObj as AnyObject).value(forKey: "lng")as AnyObject)as? Double)!{
                longitude = long
            }
            //        obj = ["title" : address, "latitude": latitude, "longitude": longitude]
            obj.setValue(address, forKey: "title")
            obj.setValue(latitude, forKey: "latitude")
            obj.setValue(longitude, forKey: "longitude")
            myLocations.add(obj)
            print(obj)
            print(myLocations)
            
            count += 1
        }
    }
        //end

    
    //end...
    
    //Mark: UITextfield delegate functions
    
    
    func tapFunction(sender:UITapGestureRecognizer){
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.searchField.becomeFirstResponder()
    }
    
    func textFieldDidChange(_ textField: UITextField) {
        let searchValue = searchField.text
        searchArray.removeAllObjects()
        for i in 0..<self.jsonArray.count
        {
            let array: NSDictionary = (self.jsonArray.object(at: i) as AnyObject) as! NSDictionary
            
            let arr = (self.addressArray.object(at: i) as AnyObject)as? String
            
            let ar = String(describing: arr?.lowercased())
            if (ar.contains(searchValue!))
            {
                self.searchArray.add(array)
            }
            else
            {
                
            }
            if (searchValue?.isEmpty)! {
                self.searchActive=false
                self.tbl.reloadData()
            }
            else {
                self.searchActive = true
            }
        }
        self.tbl.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        self.searchField.resignFirstResponder()
    }
    
    //end
    
    @IBAction func goToScanner(_ sender: UIButton) {
        let vc = ScannerViewController(
            nibName: "ScannerViewController",
            bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }
 
    //MArk : Searching on the basis of min price and max price
    
    func getDataOnPrice(){
        print(self.minPrice)
        print(self.maxPrice)
        var count = 0
        while (count < self.jsonArray.count){
            let listPrice : Int = ((jsonArray.object(at: count) as AnyObject).value(forKey: "listPrice")as! Int)
             let propertyObj : NSDictionary = (((self.jsonArray.object(at: count) as AnyObject).value(forKey: "property")as AnyObject)as? NSDictionary)!
            let bedRooms : Int = (((propertyObj as AnyObject).value(forKey: "bedrooms")as AnyObject)as? Int)!
            let area : Int = (((propertyObj as AnyObject).value(forKey: "area")as AnyObject)as? Int)!

            print(bedRooms)
            print(area)
            
            var minArea = Int()
            var maxArea = Int()
            var bedFil = Int()
            if(self.areaFilter != 0){
                minArea = self.areaFilter-100
                maxArea = self.areaFilter+100
            }
            if(self.bedFilter != 0){
                bedFil = self.bedFilter
            }
            if(self.bedFilter != 0 && self.areaFilter != 0){
                if((listPrice <= maxPrice && listPrice >= minPrice) && (bedRooms == self.bedFilter) && (area <= maxArea && area >= minArea)){
                    self.searchArray.add(self.jsonArray.object(at: count) as AnyObject)
                }
            }
            else if(self.bedFilter == 0 && self.areaFilter != 0){
                if((listPrice <= maxPrice && listPrice >= minPrice) && (area <= maxArea && area >= minArea)){
                    self.searchArray.add(self.jsonArray.object(at: count) as AnyObject)
                }
            }
            else if(self.bedFilter != 0 && self.areaFilter == 0){
                if((listPrice <= maxPrice && listPrice >= minPrice) && (bedRooms == bedFil)){
                    self.searchArray.add(self.jsonArray.object(at: count) as AnyObject)
                }
            }
            else{
                if(listPrice <= maxPrice && listPrice >= minPrice){
                    self.searchArray.add(self.jsonArray.object(at: count) as AnyObject)
                }
            }
            count += 1
        }
        
        print(self.searchArray)
        self.searchActive = true
        self.minPrice   = 0
        self.maxPrice   = 0
        self.bedFilter  = 0
        self.areaFilter = 0
        self.tbl.reloadData()
    }
    @IBAction func crossBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
