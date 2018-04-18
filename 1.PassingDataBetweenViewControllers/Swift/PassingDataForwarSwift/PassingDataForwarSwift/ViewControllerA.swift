//
//  ViewControllerA.swift
//  PassingDataForwarSwift
//
//  Created by AlexZhang on 2018/4/12.
//  Copyright © 2018 Jixin. All rights reserved.
//

import UIKit

class ViewControllerA: UIViewController, UITextFieldDelegate, ViewControllerBDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var panelView: UIView!
    
    @IBOutlet weak var userDefaulstLabel: UILabel!
    @IBOutlet weak var singletonLabel: UILabel!
    
    public var titleString: String?
    public var type: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configViews() -> Void {
        self.view.backgroundColor = UIColor.white
        self.nextButton.isEnabled = false
        self.textField.delegate = self
        self.panelView.isHidden = true
        self.tipLabel.isHidden = false
        self.textField.isHidden = false
        
        if (self.type == "Passing Data Back") {
            self.nextButton.isEnabled = true
            self.textField.isHidden = true
            self.tipLabel.text = "Click NEXT button."
        } else if (self.type == "Passing Data UserDefaults") {
            self.panelView.isHidden = false

        } else if (self.type == "Passing Data Singleton") {
            self.panelView.isHidden = false
            
        } else if (self.type == "Passing Data Notification") {
            
        }
    }
    
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewControllerB = storyboard.instantiateViewController(withIdentifier: "ViewControllerB") as! ViewControllerB
        viewControllerB.textFieldContent = "Input something here, then click BACK button. And it will  show in previous view."
        if (self.type == "Passing Data Forward") {
            viewControllerB.textFieldContent = self.textField.text
            viewControllerB.hideTextField = true
            viewControllerB.hideBackButton = true
            
        } else if (self.type == "Passing Data Back") {
            viewControllerB.delegate = self
            
            
        } else if (self.type == "Passing Data UserDefaults") {
            let userDefaults = UserDefaults.standard
            userDefaults.set(self.textField.text, forKey: "kPassingDataBetweenViewControllers")
            userDefaults.synchronize()
            
        } else if (self.type == "Passing Data Singleton") {
            self.panelView.isHidden = false
            
        } else if (self.type == "Passing Data Notification") {
            
        }
        
        self.navigationController?.pushViewController(viewControllerB, animated: true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.nextButton.isEnabled = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.tipLabel.isEnabled = textField.text != nil
    }
    
    func viewController(_ controller: ViewControllerB, didFinishEnteringItem content: String) {
        self.tipLabel.text = content
    }

}
