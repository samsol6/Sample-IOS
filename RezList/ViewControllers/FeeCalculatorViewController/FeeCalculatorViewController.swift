//
//  FeeCalculatorViewController.swift
//  RezList
//
//  Created by user 1 on 10/07/2017.
//  Copyright © 2017 ahmad. All rights reserved.
//

import UIKit

class FeeCalculatorViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var minPrice: UITextField!
    @IBOutlet weak var maxPrice: UITextField!
    @IBOutlet weak var sqFt: UITextField!
    
    
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

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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

    
    @IBAction func scanBarCode(_ sender: UIButton) {
//        let vc = ScannerViewController(
//            nibName: "ScannerViewController",
//            bundle: nil)
//        self.present(vc, animated: true, completion: nil)

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
