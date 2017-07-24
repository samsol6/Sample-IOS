//
//  SignupViewController.swift
//  RezList
//
//  Created by user 1 on 05/07/2017.
//  Copyright © 2017 ahmad. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class SignupViewController: ValidationViewController, UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    
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
        self.email.delegate = self
        self.password.delegate = self
        self.confirmPassword.delegate = self
        
        self.email.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);
        self.password.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);
        self.confirmPassword.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark: UITapGesture method
    func tapFunction(sender:UITapGestureRecognizer){
        self.email.resignFirstResponder()
        self.password.resignFirstResponder()
        self.confirmPassword.resignFirstResponder()
    }
    //end
    
    //Mark: UITextField delegate functions
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.email.resignFirstResponder()
        self.password.resignFirstResponder()
        self.confirmPassword.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        activeField = nil
    }
    
    //end

    
    @IBAction func signUpBtnClicked(_ sender: UIButton) {
        let strEmail = email.text!;
        let strPassword = password.text!;
        let strConfirmPassword = confirmPassword.text!;
        if strEmail.characters.count==0{
            ShowAlert("Email field can't be blank.")
        }else if !isValidEmail(strEmail: strEmail){
                ShowAlert("Email is invalid.")
        }else if strPassword.characters.count == 0{
           ShowAlert("Password field can't be blank.")
        }else if strConfirmPassword != strPassword{
            ShowAlert("Confirm Password does not Match")
        }
        else{
            let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
            loadingNotification.label.text = "Loading"
            let urlSignIn: String = "https://agile-depths-93396.herokuapp.com/api/v1/signup"
            let userObject = ["email": strEmail, "password": strPassword, "password_confirmation":strConfirmPassword];
            print("params are ", userObject)
            Alamofire.request(urlSignIn, method: .post, parameters: userObject, encoding: JSONEncoding.default)
                .responseJSON { response in
                    MBProgressHUD.hide(for: self.view, animated: true)
                    print("response is: ",response)
                    if response.result.isSuccess  && response.response?.statusCode == 200{
                        let dataResult: NSDictionary = (response.result.value as! NSDictionary?)!
                        if dataResult["user"] != nil {
                            
                            let alertController = UIAlertController(title: "Successfully registered", message: "Please login to continue", preferredStyle: .alert)
                            
                            let OKAction = UIAlertAction(title: "OK", style: .default) { action in
                                self.dismiss(animated: true, completion: nil)                            }
                            alertController.addAction(OKAction)
                            self.present(alertController, animated: true)
                        }
                    }
                    else{
                        let alert = UIAlertController(title: "Alert", message: "Failed, Please try again.", preferredStyle: UIAlertControllerStyle.alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        
                        self.present(alert, animated: true, completion: nil)
                    }
            }
        }
    }
    
    @IBAction func goToSignin(_ sender: UIButton) {

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
