//
//  FlatFeeCalculatorViewController.swift
//  RezList
//
//  Created by user 1 on 10/07/2017.
//  Copyright © 2017 ahmad. All rights reserved.
//

import UIKit

class FlatFeeCalculatorViewController: UIViewController {
    
    @IBOutlet weak var mainView: UIView!

    @IBOutlet weak var HomeRangeValue: UILabel!
    @IBOutlet weak var minSliderVal: UILabel!
    @IBOutlet weak var maxSliderVal: UILabel!
    
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var agentLbl: UILabel!
    @IBOutlet weak var traditionalCommission: UILabel!
    
    @IBOutlet weak var rezListServiceFee: UILabel!
    @IBOutlet weak var yourSave: UILabel!
    @IBOutlet weak var seller: UILabel!
    @IBOutlet weak var seller1: UILabel!
    @IBOutlet weak var seller2: UILabel!
    @IBOutlet weak var seller3: UILabel!
    
    
    @IBOutlet weak var buyer: UILabel!
    @IBOutlet weak var buyer1: UILabel!
    @IBOutlet weak var buyer2: UILabel!
    @IBOutlet weak var buyer3: UILabel!
    
    @IBOutlet weak var totalCommision: UILabel!
    @IBOutlet weak var totalCommission1: UILabel!
    @IBOutlet weak var totalCommission2: UILabel!
    @IBOutlet weak var totalCommission3: UILabel!
    
    
    //Mark: View life cycle **********
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //setting view color
        self.mainView.backgroundColor = UIColor(red:0.97, green:0.98, blue:1.00, alpha:1.0)
        
        
        //adding gesture recognizer to the uislider
        self.slider.addTarget(self, action:#selector(sliderChanged) , for: .valueChanged)
        // Do any additional setup after loading the view.
        
        self.addLabelBorders()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //End********

    //Mark: Gesture and custom functions
    
    func sliderChanged(sender: UISlider){
        print(sender.value)
//        [self sendActionsForControlEvents:UIControlEventValueChanged];
        self.HomeRangeValue.text = String(sender.value)
    }
    func addLabelBorders(){
        //setting border
        agentLbl.layer.borderWidth = 0.5
        agentLbl.layer.borderColor = UIColor(red:0.87, green:0.88, blue:0.90, alpha:1.0).cgColor
        
        traditionalCommission.layer.borderWidth = 0.5
        traditionalCommission.layer.borderColor = UIColor(red:0.87, green:0.88, blue:0.90, alpha:1.0).cgColor
        
        rezListServiceFee.layer.borderWidth = 0.5
        rezListServiceFee.layer.borderColor = UIColor(red:0.87, green:0.88, blue:0.90, alpha:1.0).cgColor
        
        yourSave.layer.borderWidth = 0.5
        yourSave.layer.borderColor = UIColor(red:0.87, green:0.88, blue:0.90, alpha:1.0).cgColor
        
        seller.layer.borderWidth = 0.5
        seller.layer.borderColor = UIColor(red:0.87, green:0.88, blue:0.90, alpha:1.0).cgColor
        seller.backgroundColor = UIColor(red:0.97, green:0.98, blue:1.00, alpha:1.0)
        
        seller1.layer.borderWidth = 0.5
        seller1.layer.borderColor = UIColor(red:0.87, green:0.88, blue:0.90, alpha:1.0).cgColor
        seller1.backgroundColor = UIColor(red:0.97, green:0.98, blue:1.00, alpha:1.0)
        
        seller2.layer.borderWidth = 0.5
        seller2.layer.borderColor = UIColor(red:0.87, green:0.88, blue:0.90, alpha:1.0).cgColor
        seller2.backgroundColor = UIColor(red:0.97, green:0.98, blue:1.00, alpha:1.0)
        
        seller3.layer.borderWidth = 0.5
        seller3.layer.borderColor = UIColor(red:0.87, green:0.88, blue:0.90, alpha:1.0).cgColor
        seller3.backgroundColor = UIColor(red:0.97, green:0.98, blue:1.00, alpha:1.0)
        
        buyer.layer.borderWidth = 0.5
        buyer.layer.borderColor = UIColor(red:0.87, green:0.88, blue:0.90, alpha:1.0).cgColor
        buyer.backgroundColor = UIColor(red:0.97, green:0.98, blue:1.00, alpha:1.0)
        
        buyer1.layer.borderWidth = 0.5
        buyer1.layer.borderColor = UIColor(red:0.87, green:0.88, blue:0.90, alpha:1.0).cgColor
        buyer1.backgroundColor = UIColor(red:0.97, green:0.98, blue:1.00, alpha:1.0)
        
        buyer2.layer.borderWidth = 0.5
        buyer2.layer.borderColor = UIColor(red:0.87, green:0.88, blue:0.90, alpha:1.0).cgColor
        buyer2.backgroundColor = UIColor(red:0.97, green:0.98, blue:1.00, alpha:1.0)
        
        buyer3.layer.borderWidth = 0.5
        buyer3.layer.borderColor = UIColor(red:0.87, green:0.88, blue:0.90, alpha:1.0).cgColor
        buyer3.backgroundColor = UIColor(red:0.97, green:0.98, blue:1.00, alpha:1.0)
        
        totalCommision.layer.borderWidth = 0.5
        totalCommision.layer.borderColor = UIColor(red:0.87, green:0.88, blue:0.90, alpha:1.0).cgColor
        totalCommision.backgroundColor = UIColor(red:0.97, green:0.98, blue:1.00, alpha:1.0)
        
        totalCommission1.layer.borderWidth = 0.5
        totalCommission1.layer.borderColor = UIColor(red:0.87, green:0.88, blue:0.90, alpha:1.0).cgColor
        totalCommission1.backgroundColor = UIColor(red:0.97, green:0.98, blue:1.00, alpha:1.0)
        
        totalCommission2.layer.borderWidth = 0.5
        totalCommission2.layer.borderColor = UIColor(red:0.87, green:0.88, blue:0.90, alpha:1.0).cgColor
        totalCommission2.backgroundColor = UIColor(red:0.97, green:0.98, blue:1.00, alpha:1.0)
        
        totalCommission3.layer.borderWidth = 0.5
        totalCommission3.layer.borderColor = UIColor(red:0.87, green:0.88, blue:0.90, alpha:1.0).cgColor
        
        //end

    }
    
//    override func trackRectForBounds(bounds: CGRect) -> CGRect {
//        return CGRectMake(0, 0, bounds.size.width, 4)
//    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
