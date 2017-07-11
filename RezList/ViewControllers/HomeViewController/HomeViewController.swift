//
//  HomeViewController.swift
//  RezList
//
//  Created by user 1 on 05/07/2017.
//  Copyright © 2017 ahmad. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var rezListLogo: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
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
        //apple method
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
    }
    
    
    //Mark: UITextfield delegate functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailField.tintColor = UIColor.white
        self.passwordField.tintColor = UIColor.white
        // Do any additional setup after loading the view.
        
        self.scrollView.contentSize = CGSize(width: 320, height: 568)
        let tap = UITapGestureRecognizer(target: self, action: #selector
            (tapFunction))
        self.scrollView.addGestureRecognizer(tap)
        
        //register notification
        self.registerForKeyboardNotifications()
        //end
        
        //set Textfield delegate
        self.emailField.delegate = self
        self.passwordField.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark: UITapGesture method
    func tapFunction(sender:UITapGestureRecognizer){
        self.emailField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
    }
    //end
    
    //Mark: UITextField delegate functions
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.emailField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        activeField = nil
    }
    
    //end

    @IBAction func signinBtnClicked(_ sender: UIButton) {
        //let vc = SearchViewController(
         //   nibName: "SearchViewController",
         //   bundle: nil)
        //self.present(vc, animated: true, completion: nil)
        
        
        let strEmail=emailField.text!;
        let strPassword=passwordField.text!;
        if strEmail.characters.count==0{
            let alert = UIAlertController(title: "Alert", message: "Email field can't be blank.", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
//        }else if !isValidEmail(strEmail: strEmail){
//            let alert = UIAlertController(title: "Alert", message: "Email is invalid.", preferredStyle: UIAlertControllerStyle.alert)
//            
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//            
//            self.present(alert, animated: true, completion: nil)
        }else if strPassword.characters.count == 0{
            let alert = UIAlertController(title: "Alert", message: "Password field can't be blank.", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }else if strPassword.characters.count < 8{
            let alert = UIAlertController(title: "Alert", message: "Password length should be greate or equal to 8.", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }else{
            let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
            loadingNotification.label.text = "Loading"
            //            let urlSignIn: String = "https://playinn-admin.herokuapp.com/api/v1/signin"
            let urlSignIn: String = "https://agile-depths-93396.herokuapp.com/api/v1/signin"
            let userObject = ["user": ["email": strEmail, "password": strPassword]];
            print("params are ", userObject)
            Alamofire.request(urlSignIn, method: .post, parameters: userObject, encoding: JSONEncoding.default)
                .responseJSON { response in
                    MBProgressHUD.hide(for: self.view, animated: true)
                    print("response is: ",response)
                    if response.result.isSuccess  && response.response?.statusCode == 200{
                        let dataResult: NSDictionary = (response.result.value as! NSDictionary?)!
                        if dataResult["user"] != nil {
                            let dict = (dataResult.value(forKey: "user") as AnyObject) as! NSDictionary
                            let id : Int = (dict.value(forKey: "id") as AnyObject) as! Int
                            let token = (dict.value(forKey: "authentication_token") as AnyObject) as! String
                            let strName = dict.value(forKey: "first_name") as? String
                            let age = dict.value(forKey: "age") as? String
                            let location = dict.value(forKey: "location") as? String
                            let pictureUrl = dict.value(forKey: "picture") as? String
                            let email = dict.value(forKey: "email") as? String
                            let lastName = dict.value(forKey: "last_name") as?  String
                            let phone = dict["phone"] as? String
                            UserDefaults.standard.set(String(describing: id), forKey: "id")
                            UserDefaults.standard.set(token, forKey: "authentication_token")
                            UserDefaults.standard.set(true,forKey:"isUserLoggedIn")
                            UserDefaults.standard.set(strName, forKey: "userName");
                            UserDefaults.standard.set(age, forKey: "age")
                            UserDefaults.standard.set(location, forKey: "location")
                            UserDefaults.standard.set(pictureUrl, forKey: "pictureUrl")
                            UserDefaults.standard.set(email, forKey: "email")
                            UserDefaults.standard.set(lastName, forKey: "lastName")
                            UserDefaults.standard.set(phone, forKey: "phone")
                            UserDefaults.standard.synchronize()
                            self.performSegue(withIdentifier: "Home", sender: self)
                        }
                        else{
                            let strMessageError: NSString = dataResult.value(forKey: "message") as! NSString
                            self.ShowAlert(strMessageError as String)
                        }
                    }
                    else{
                        self.ShowAlert("Failed, Please try again.")
                    }
            }

    }
    
    
    @IBAction func goToSignup(_ sender: UIButton) {
        let vc = SignupViewController(
            nibName: "SignupViewController",
            bundle: nil)
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