//
//  Host.swift
//  DelegateDemoSwift
//
//  Created by AlexZhang on 2018/4/18.
//  Copyright © 2018 Jixin. All rights reserved.
//

import UIKit

@objc protocol HostDelegate: NSObjectProtocol {
    
    func host(_ host: Host, willDisplayPicture content: String) -> Void
    
    @objc optional func host (_ host: Host, willPlayAudio content: String) -> Void
}

class Host: UIView {
    
    public weak var delegate:HostDelegate?
    
    lazy var playButton: UIButton = {
        let playButton = UIButton.init(type: UIButtonType.system)
        playButton.layer.cornerRadius = 4
        playButton.setTitle("play", for: UIControlState.normal)
        playButton.backgroundColor = UIColor.blue
        playButton.frame = CGRect(x: (self.frame.size.width - 60) / 2.0 , y: (self.frame.size.height - 44) / 2.0, width: 60, height: 44)
        playButton.addTarget(self, action: #selector(playButtonClicked(_:)), for: UIControlEvents.touchUpInside)
        return playButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        confitSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func confitSubviews() -> Void {
        self.addSubview(self.playButton)
    }
    
    @IBAction func playButtonClicked(_ button:UIButton) {
        
        if (self.delegate != nil &&
            (self.delegate?.responds(to: #selector(HostDelegate.host(_:willDisplayPicture:))))!) {
            self.delegate?.host(self, willDisplayPicture: "你要的画面")
        }
    }
}
