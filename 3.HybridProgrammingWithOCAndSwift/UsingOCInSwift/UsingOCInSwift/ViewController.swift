//
//  ViewController.swift
//  UsingOCInSwift
//
//  Created by AlexZhang on 2018/4/19.
//  Copyright © 2018 Jixin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var instanceOfCustomObject: CustomObject = CustomObject()

    override func viewDidLoad() {
        super.viewDidLoad()
        instanceOfCustomObject.someProperty = "Hello World"
        print(instanceOfCustomObject.someProperty)
        instanceOfCustomObject.someMethod()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

