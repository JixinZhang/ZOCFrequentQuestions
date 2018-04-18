//
//  ViewController.swift
//  DelegateDemoSwift
//
//  Created by AlexZhang on 2018/4/18.
//  Copyright © 2018 Jixin. All rights reserved.
//

import UIKit

let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height

class Monitor: UIViewController, HostDelegate {

    var playButton: UIButton!
    lazy var host: Host = {
        let host = Host.init(frame: CGRect(x: 0, y: 200, width: kScreenWidth, height: 100))
        host.delegate = self        //Monitor成为host的代理
        return host
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(host)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func host(_ host: Host, willDisplayPicture content: String) {
        NSLog("display content = %@", content)
    }
    
    func host(_ host: Host, willPlayAudio content: String) {
        NSLog("playAudio content = %@", content)
    }
}

