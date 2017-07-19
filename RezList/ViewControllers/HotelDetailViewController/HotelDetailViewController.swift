//
//  HotelDetailViewController.swift
//  RezList
//
//  Created by user 1 on 17/07/2017.
//  Copyright © 2017 ahmad. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class HotelDetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var houseImg: UIImageView!
    
    @IBOutlet weak var beds: UILabel!
    @IBOutlet weak var baths: UILabel!
    @IBOutlet weak var area: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var price: UILabel!
    
    
    @IBOutlet weak var desc: UITextView!
    
    
    @IBOutlet weak var MapStreetLocation: UILabel!
    
    @IBOutlet weak var style: UILabel!
    @IBOutlet weak var propertyType: UILabel!
    @IBOutlet weak var community: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var mlsNO: UILabel!
    @IBOutlet weak var builtYear: UILabel!
    @IBOutlet weak var lotSize: UILabel!
    @IBOutlet weak var noOfBaths: UILabel!
    
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var addressMapView: UIView!
    @IBOutlet weak var keyDetailView: UIView!
    
    var dict = NSDictionary()
    var fullAddress = String()
    
    
    @IBAction func openGallery(_ sender: UIButton) {
        let vc = HotelScreensViewController(
            nibName: "HotelScreensViewController",
            bundle: nil)
        vc.dict = self.dict
        self.present(vc, animated: true, completion: nil)

    }
    
    
    
    //Mark: View life cycle...
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.scrollView.contentSize = CGSize(width: 320, height: 568)
        setBorders()
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //end...
    
    
    //Mark: custom function to get data...
    
    func setBorders(){
        self.descriptionView.layer.borderWidth = 1
        self.descriptionView.layer.borderColor = UIColor(red:0.83, green:0.83, blue:0.83, alpha:1.0).cgColor
        
        self.addressMapView.layer.borderWidth = 1
        self.addressMapView.layer.borderColor = UIColor(red:0.83, green:0.83, blue:0.83, alpha:1.0).cgColor
        
        self.keyDetailView.layer.borderWidth = 1
        self.keyDetailView.layer.borderColor = UIColor(red:0.83, green:0.83, blue:0.83, alpha:1.0).cgColor
    }
    
    func getData(){
        let propertyObj : NSDictionary = (((dict as AnyObject).value(forKey: "property")as AnyObject)as? NSDictionary)!
        let addressObj : NSDictionary = (((dict as AnyObject).value(forKey: "address")as AnyObject)as? NSDictionary)!
        let photoObj : NSArray = (((dict as AnyObject).value(forKey: "photos")as AnyObject)as? NSArray)!
        let geoLocationObj : NSDictionary = (((dict as AnyObject).value(forKey: "geo")as AnyObject)as? NSDictionary)!
        
        //parsing data from property object
        let bedRooms : Int = (((propertyObj as AnyObject).value(forKey: "bedrooms")as AnyObject)as? Int)!
        var numBath = Int()
        if let bathRooms : Int = (((propertyObj as AnyObject).value(forKey: "bathsFull")as AnyObject)as? Int){
            numBath = bathRooms
        }
        
        let Price : Int = ((dict as AnyObject).value(forKey: "listPrice")as! Int)
        print(price)
        self.price.text = "$"+String(Price)
        
        let area : Int = (((propertyObj as AnyObject).value(forKey: "area")as AnyObject)as? Int)!
        
        //getting address
        let address : String = (((addressObj as AnyObject).value(forKey: "full")as AnyObject)as? String)!
        self.fullAddress = address
        let streetName : String = (((addressObj as AnyObject).value(forKey: "streetName")as AnyObject)as? String)!
        let streetNumber : String = (((addressObj as AnyObject).value(forKey: "streetNumberText")as AnyObject)as? String)!
        
        self.MapStreetLocation.text = streetNumber + " " + streetName
        
        self.location.text = address
        self.beds.text = String(bedRooms)
        self.baths.text = String(numBath)
        self.area.text = String(area)
        
        //getting lot description
        let description : String = (((propertyObj as AnyObject).value(forKey: "lotDescription")as AnyObject)as? String)!
        self.desc.text = description
        
        //Key details
        let style : String = (((propertyObj as AnyObject).value(forKey: "style")as AnyObject)as? String)!
        let propertyType : String = (((propertyObj as AnyObject).value(forKey: "type")as AnyObject)as? String)!
//        let community : String = (((propertyObj as AnyObject).value(forKey: "bedrooms")as AnyObject)as? String)!
        let country : String = (((addressObj as AnyObject).value(forKey: "country")as AnyObject)as? String)!
        let mlsNum : Int = (((dict as AnyObject).value(forKey: "mlsId")as AnyObject)as? Int)!
        let built : Int = (((propertyObj as AnyObject).value(forKey: "yearBuilt")as AnyObject)as? Int)!
        let lotSize : String = (((propertyObj as AnyObject).value(forKey: "lotSize")as AnyObject)as? String)!
        
        
        self.style.text = style
        self.propertyType.text = propertyType
        self.community.text = "N/A"
        self.country.text = country
        self.mlsNO.text = String(mlsNum)
        self.builtYear.text = String(built)
        self.lotSize.text = lotSize
        
        self.noOfBaths.text = String(numBath)
        
        //getting image
        let uniqueKey : String = (((addressObj as AnyObject).value(forKey: "unit")as AnyObject)as? String)!
        
        // getting photo url from the photo object
        if let photoUrl : String = ((photoObj.object(at: 1) as AnyObject) as? String){
            if let imgData = UserDefaults.standard.object(forKey: uniqueKey) as? Data
            {
                if let image = UIImage(data: imgData as Data)
                {
                    //set image in UIImageView imgSignature
                    self.houseImg.image = image
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
                        self.houseImg.image = image
                        
                        //                    let strLeagueId = String(self.gameId)
                        let imageData = UIImageJPEGRepresentation(image, 1.0)
                        UserDefaults.standard.set(imageData, forKey: uniqueKey)
                        UserDefaults.standard.synchronize()
                    }
                }
            }
            
        }
    
    }

    //end...
    @IBAction func goOnMap(_ sender: UIButton) {
        var latitude = Double()
        var longitude = Double()
         let geoLocationObj : NSDictionary = (((dict as AnyObject).value(forKey: "geo")as AnyObject)as? NSDictionary)!
        if let lat: Double = (((geoLocationObj as AnyObject).value(forKey: "lat")as AnyObject)as? Double)!{
            latitude = lat
        }
        if let long: Double = (((geoLocationObj as AnyObject).value(forKey: "lng")as AnyObject)as? Double)!{
            longitude = long
        }

        let vc = MapHouseViewController(
            nibName: "MapHouseViewController",
            bundle: nil)
        vc.latitude  = latitude
        vc.longitude = longitude
        vc.address = fullAddress
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func mapBtnClicked(_ sender: UIButton) {
        var latitude = Double()
        var longitude = Double()
        let geoLocationObj : NSDictionary = (((dict as AnyObject).value(forKey: "geo")as AnyObject)as? NSDictionary)!
        if let lat: Double = (((geoLocationObj as AnyObject).value(forKey: "lat")as AnyObject)as? Double)!{
            latitude = lat
        }
        if let long: Double = (((geoLocationObj as AnyObject).value(forKey: "lng")as AnyObject)as? Double)!{
            longitude = long
        }
        
        let vc = MapHouseViewController(
            nibName: "MapHouseViewController",
            bundle: nil)
        vc.latitude  = latitude
        vc.longitude = longitude
        vc.address = fullAddress
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func openStreetView(_ sender: UIButton) {
        var latitude = Double()
        var longitude = Double()
        let geoLocationObj : NSDictionary = (((dict as AnyObject).value(forKey: "geo")as AnyObject)as? NSDictionary)!
        if let lat: Double = (((geoLocationObj as AnyObject).value(forKey: "lat")as AnyObject)as? Double)!{
            latitude = lat
        }
        if let long: Double = (((geoLocationObj as AnyObject).value(forKey: "lng")as AnyObject)as? Double)!{
            longitude = long
        }
        
        let vc = MapHouseViewController(
            nibName: "MapHouseViewController",
            bundle: nil)
        vc.latitude  = latitude
        vc.longitude = longitude
        vc.address = fullAddress
        self.present(vc, animated: true, completion: nil)
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
