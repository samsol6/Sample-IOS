//
//  HotelScreensViewController.swift
//  RezList
//
//  Created by user 1 on 18/07/2017.
//  Copyright © 2017 ahmad. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class HotelScreensViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var pageNum: UILabel!
    @IBOutlet weak var colView: UICollectionView!
    
    var dict = NSDictionary()
    var photoArray = NSArray()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let photoObj : NSArray = (((dict as AnyObject).value(forKey: "photos")as AnyObject)as? NSArray)!
        self.photoArray = photoObj
        
        self.colView.register(UINib(nibName: "HotelScreenCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "hotelCell")
            
        self.colView.delegate   = self
        self.colView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        colView.collectionViewLayout = layout
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark : UICollectionView Delegate functions
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSize: CGRect = UIScreen.main.bounds
        
        let screenWidth = screenSize.width
        
//        return CGSize(width: screenWidth, height: 203);
        let itemWidth = self.colView.bounds.width
        let itemHeight = self.colView.bounds.height
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // 1
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //setting text
        self.pageNum.text = "\(indexPath.row + 1)" + " of " + "\(self.photoArray.count)"
        //end
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return self.photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.colView.dequeueReusableCell(withReuseIdentifier: "hotelCell", for: indexPath) as! HotelScreenCollectionViewCell
        
        let addressObj : NSDictionary = (((dict as AnyObject).value(forKey: "address")as AnyObject)as? NSDictionary)!
        let photoObj : NSArray = (((dict as AnyObject).value(forKey: "photos")as AnyObject)as? NSArray)!
        
         let uniqueKey : String = (((addressObj as AnyObject).value(forKey: "unit")as AnyObject)as? String)!
        if let photoUrl : String = ((photoObj.object(at: indexPath.row) as AnyObject) as? String){
            if let imgData = UserDefaults.standard.object(forKey: uniqueKey+"\(indexPath.row)") as? Data
            {
                if let image = UIImage(data: imgData as Data)
                {
                    //set image in UIImageView imgSignature
                    cell.hotelCell.image = image
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
                        cell.hotelCell.image = image
                        
                        //                    let strLeagueId = String(self.gameId)
                        let imageData = UIImageJPEGRepresentation(image, 1.0)
                        UserDefaults.standard.set(imageData, forKey: uniqueKey+"\(indexPath.row)")
                        UserDefaults.standard.synchronize()
                    }
                }
            }
            
        }
            return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
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
