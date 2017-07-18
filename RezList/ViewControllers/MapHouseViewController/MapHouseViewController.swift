//
//  MapHouseViewController.swift
//  RezList
//
//  Created by user 1 on 18/07/2017.
//  Copyright © 2017 ahmad. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapHouseViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var latitude = Double()
    var longitude = Double()
    var address = String()
    
    var myLocations = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var obj = NSMutableDictionary()
        obj.setValue(address, forKey: "title")
        obj.setValue(latitude, forKey: "latitude")
        obj.setValue(longitude, forKey: "longitude")
        myLocations.add(obj)

        if let location : NSMutableDictionary = myLocations.object(at: 0) as? NSMutableDictionary{
            let annotation = MKPointAnnotation()
            let title : String = (location.value(forKey: "title") as? String)!
            let lat : Double = (location.value(forKey: "latitude") as? Double)!
            let long : Double = (location.value(forKey: "longitude") as? Double)!
            annotation.title = title
            annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            mapView.addAnnotation(annotation)
        }
        
        mapView.showAnnotations(mapView.annotations, animated: true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(_ sender: UIButton) {
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
