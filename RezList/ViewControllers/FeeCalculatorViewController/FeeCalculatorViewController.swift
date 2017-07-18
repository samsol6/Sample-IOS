//
//  FeeCalculatorViewController.swift
//  RezList
//
//  Created by user 1 on 10/07/2017.
//  Copyright © 2017 ahmad. All rights reserved.
//

import UIKit

class FeeCalculatorViewController: ValidationViewController, UITextFieldDelegate, UIPickerViewDelegate,  UIPickerViewDataSource {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var minPrice: UITextField!
    @IBOutlet weak var maxPrice: UITextField!
    @IBOutlet weak var sqFt: UITextField!
    
    @IBOutlet weak var propertyPicker: UIPickerView!
    @IBOutlet weak var bedsPicker: UIPickerView!
    
    
    var bedsArray = NSArray()
    var bedString = String()
    
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
//        var info = notification.userInfo!
//        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
//        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize!.height, 0.0)
//        self.scrollView.contentInset = contentInsets
//        self.scrollView.scrollIndicatorInsets = contentInsets
//        self.view.endEditing(true)
////        self.scrollView.isScrollEnabled = false
//        
////        self.scrollView.contentSize = CGSize(width: 320, height: 568)
        
        
        //apple method
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.scrollView.contentSize = CGSize(width: 320, height: 568)
        let tap = UITapGestureRecognizer(target: self, action: #selector
            (tapFunction))
        self.scrollView.addGestureRecognizer(tap)
        
        //register notification
        self.registerForKeyboardNotifications()
        //end
        
        //set Textfield delegate
        self.firstName.delegate = self
        self.lastName.delegate = self
        self.email.delegate = self
        self.zipCode.delegate = self
        self.phone.delegate = self
        self.minPrice.delegate = self
        self.maxPrice.delegate = self
        self.sqFt.delegate = self

        bedsArray = ["1", "2", "3", "4", "5"]
        self.propertyPicker.delegate = self
        self.bedsPicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark: UIPicker view delegate functions
    
    //Mark: PickerView delegate functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        
        return 1;
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if(pickerView == self.propertyPicker){
            return 5
        }
        else{
            return 5
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        //        // return list[row]
        if(pickerView == self.propertyPicker){
            return "House/Condo"
        }
        else{
            return bedsArray.object(at: row) as? String
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){

        if(pickerView == self.propertyPicker){
            
        }
        else{
            let n :String=(((self.bedsArray.object(at: row) as AnyObject)) as? String)!
            bedString = n
            
        }
        
    }
    
    //end
    
    //Mark: UITapGesture method
    func tapFunction(sender:UITapGestureRecognizer){
        self.firstName.resignFirstResponder()
        self.lastName.resignFirstResponder()
        self.email.resignFirstResponder()
        self.zipCode.resignFirstResponder()
        self.phone.resignFirstResponder()
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
        self.firstName.resignFirstResponder()
        self.lastName.resignFirstResponder()
        self.email.resignFirstResponder()
        self.zipCode.resignFirstResponder()
        self.phone.resignFirstResponder()
        self.minPrice.resignFirstResponder()
        self.maxPrice.resignFirstResponder()
        self.sqFt.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        activeField = nil
    }
    
    //end

    
    @IBAction func filterFlatsBtnClicked(_ sender: UIButton) {
        
        if(self.minPrice.text?.characters.count == 0){
            ShowAlert("please enter min price")
            return
        }
        if(self.maxPrice.text?.characters.count == 0){
            ShowAlert("please enter max price")
            return
        }
        
        var minPriceInt = Int()
        var maxPriceInt = Int()
        var areaInt = Int()
        if let minPrice : String = self.minPrice.text{
            minPriceInt = Int(minPrice)!
        }
        if let maxPrice : String = self.maxPrice.text{
            maxPriceInt = Int(maxPrice)!
        }
        if let area : String = self.sqFt.text{
            if( self.sqFt.text?.characters.count != 0){
                areaInt = Int(area)!
            }
        }
        
        
        let vc = SearchViewController(
            nibName: "SearchViewController",
            bundle: nil)
        vc.minPrice = minPriceInt
        vc.maxPrice = maxPriceInt
        if(self.bedString.characters.count != 0){
            vc.bedFilter   = Int(bedString)!
        }
        vc.areaFilter  = areaInt
        
        
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func goBack(_ sender: UIButton) {
//        let vc = FeeCalculatorViewController(
//            nibName: "FeeCalculatorViewController",
//            bundle: nil)
//        self.present(vc, animated: true, completion: nil)
        
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
