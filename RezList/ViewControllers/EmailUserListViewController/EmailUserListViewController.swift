//
//  EmailUserListViewController.swift
//  RezList
//
//  Created by user 1 on 14/07/2017.
//  Copyright © 2017 ahmad. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class EmailUserListViewController: UIViewController, UITextFieldDelegate {

    var email = String()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SendEmail(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Please enter your email", message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Send", style: .default, handler: {
            alert -> Void in
            let textField = alertController.textFields![0] as UITextField
            self.email = textField.text!
            self.send()
            // do something with textField
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addTextField { (textField) -> Void in
//            searchTextField = textField
            textField.delegate = self //REQUIRED
            textField.placeholder = "Enter your email"
        }
        
        self.present(alertController, animated: true, completion: nil)
    }

    func send(){
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.label.text = "Loading"
        let urlSignIn: String = "https://agile-depths-93396.herokuapp.com/api/v1/export"
        let userObject = ["email": self.email];
        print("params are ", userObject)
        Alamofire.request(urlSignIn, method: .post, parameters: userObject, encoding: JSONEncoding.default)
            .responseJSON { response in
                MBProgressHUD.hide(for: self.view, animated: true)
                print("response is: ",response)
                if response.result.isSuccess  && response.response?.statusCode == 200{
                    let dataResult: NSDictionary = (response.result.value as! NSDictionary?)!
                    if let str : String = (((dataResult as AnyObject).value(forKey: "result")as AnyObject)as? String)!{
                    if(str == "UnSuccessful"){
                        let alert = UIAlertController(title: "Try again", message: "Invalid email", preferredStyle: UIAlertControllerStyle.alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        
                        self.present(alert, animated: true, completion: nil)
                    }
                    else{
                        let alertController = UIAlertController(title: "Success", message: "You have successfully sent email to your account", preferredStyle: .alert)
                        
                        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
                            self.dismiss(animated: true, completion: nil)
                        }
                        alertController.addAction(OKAction)
                        self.present(alertController, animated: true)
                    }
                }
            }
        }

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
