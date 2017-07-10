//
//  FilterViewController.swift
//  RezList
//
//  Created by user 1 on 06/07/2017.
//  Copyright © 2017 ahmad. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

  
    @IBOutlet weak var statusPicker: UIPickerView!
    @IBOutlet weak var beds: UIPickerView!
    @IBOutlet weak var propertyType: UIPickerView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var baths: UIPickerView!

    @IBOutlet weak var minPrice: UITextField!
    
    @IBOutlet weak var maxPrice: UITextField!
    @IBOutlet weak var sqFt: UITextField!
    
    
    var statusPickerArray = NSMutableArray()
    
    var activeField: UITextField?
    
    //Mark: keyboard methods
    func registerForKeyboardNotifications()
    {
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    func deregisterFromKeyboardNotifications()
    {
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWasShown(notification: NSNotification)
    {
        //Need to calculate keyboard exact size due to Apple suggestions
//        self.scrollView.isScrollEnabled = true
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
        
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if let activeField = self.activeField {
            if (!aRect.contains(activeField.frame.origin)){
                self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
        
    }
    
    func keyboardWillBeHidden(notification: NSNotification)
    {
        //Once keyboard disappears, restore original positions
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
//        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize!.height, 0.0)
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
//        self.view.endEditing(true)
//        self.scrollView.isScrollEnabled = false
        
    }
    
    //Mark: view lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        statusPickerArray = ["For sale", "open Homes", "Pending", "New (Writing 7 days)", "Sold"]
        
        //register notification
        self.registerForKeyboardNotifications()
        //end
        
        self.scrollView.contentSize = CGSize(width: 320, height: 568)
        self.scrollView.isUserInteractionEnabled = true
        let tap2 = UITapGestureRecognizer(target: self, action: #selector
            (showPickerRadius))
        self.scrollView.addGestureRecognizer(tap2)

        //end
        //changing scrollview color
        self.scrollView.backgroundColor = UIColor(red:0.97, green:0.98, blue:1.00, alpha:1.0)
        //end
        
        //set pickerView delegate
        self.propertyType.delegate = self
        self.propertyType.dataSource = self
        self.beds.delegate = self
        self.beds.dataSource = self
        self.baths.delegate = self
        self.baths.dataSource = self
        self.statusPicker.delegate = self
        self.statusPicker.dataSource = self
        
        //set Textfield delegate
        self.minPrice.delegate = self
        self.maxPrice.delegate = self
        self.sqFt.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark: UITapGesture method
    func showPickerRadius(sender:UITapGestureRecognizer){
        self.minPrice.resignFirstResponder()
        self.maxPrice.resignFirstResponder()
        self.sqFt.resignFirstResponder()
    }
    //end
    
    //Mark: UITextField delegate functions
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.minPrice.resignFirstResponder()
        self.maxPrice.resignFirstResponder()
        self.sqFt.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        activeField = nil
    }
    
    //end
    
    //Mark: PickerView delegate functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        
        return 1;
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if(pickerView == self.propertyType){
            return 3
        }
        else if (pickerView == self.beds){
            return 5
        }
        else{
            return 5
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
//        // return list[row]
        if(pickerView == self.propertyType){
            return "House/Condo"
        }
        else if (pickerView == self.beds){
            return "Any"
        }
        else if(pickerView == self.baths){
            return "1+"
        }
        else{
            return statusPickerArray.object(at: row) as? String
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
//        
//        if(pickerView == self.gameSelectionList){
//            let n :String=(((self.resultGame.object(at: row) as AnyObject).value(forKey: "name") as AnyObject) as? String)!
//            txtFieldGames.text = n
//            gameId = (((self.resultGame.object(at: row) as AnyObject).value(forKey: "id") as AnyObject) as? Int)!
//            
//            UserDefaults.standard.set(self.gameId, forKey: "edited_sport_id")
//            UserDefaults.standard.synchronize()
//            gameSelectionList.isHidden=true
//        }
//        else{
//            let n :String=(((self.radiusArray.object(at: row) as AnyObject)) as? String)!
//            lblSearchValue.text = n
//            radiusSelectionList.isHidden=true
//        }
        
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
