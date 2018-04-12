//
//  ViewControllerB.swift
//  PassingDataForwarSwift
//
//  Created by AlexZhang on 2018/4/12.
//  Copyright © 2018 Jixin. All rights reserved.
//

import UIKit

protocol ViewControllerBDelegate: NSObjectProtocol {
    func viewController(_ controller: ViewControllerB, didFinishEnteringItem content: String) -> Void
}

typealias Block = (_ content: String) -> Void

class ViewControllerB: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var panelView: UIView!
    @IBOutlet weak var userDefaultsLabel: UILabel!
    @IBOutlet weak var singletonLabel: UILabel!
    
    public var textFieldContent: String?
    public var hideTextField: Bool!
    public var hideBackButton: Bool!
    
    public var block: Block?
    
    public weak var delegate: ViewControllerBDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideBackButton = false
        self.hideTextField = false
        configViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configViews() -> Void {
        self.view.backgroundColor = UIColor.white
        self.textField.isHidden = self.hideTextField
        self.backButton.isHidden = self.hideBackButton
        
        self.tipLabel.text = String.init(format: "'%@' was come from previous page", self.textFieldContent!)
        
        let userDefaults = UserDefaults.standard
        let content = userDefaults.object(forKey: "kPassingDataBetweenViewControllers") as? String
        self.userDefaultsLabel.text = content
    }

    @IBAction func backButtonClicked(_ sender: UIButton) {
        let content:String = self.textField.text!
        self.textFieldContent = content
        if (self.delegate != nil) {
            self.delegate?.viewController(self, didFinishEnteringItem: content)
        }
        
//        if (self.block != nil) {
//            self.block!(content)
//        }
    }

}
