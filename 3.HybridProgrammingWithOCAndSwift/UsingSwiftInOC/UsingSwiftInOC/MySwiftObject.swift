//
//  MySwiftObject.swift
//  UsingSwiftInOC
//
//  Created by AlexZhang on 2018/4/24.
//  Copyright © 2018 Jixin. All rights reserved.
//

import UIKit

class MySwiftObject: NSObject {
    public var someProperty: String = "Some Initializer Val"
    
    public func someFunction(someArg:AnyObject) -> String {
        let retrunVal = "You sent me : " + (someArg as! String)
        return retrunVal
    }
}
