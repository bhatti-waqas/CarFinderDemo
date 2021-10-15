//
//  Utils.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/15/21.
//

import Foundation
public class Run {
    
    @discardableResult
    public class func delayed(_ delayInSeconds: Double, block: @escaping SimpleCall) -> SimpleCall? {
        
        var isCancelled = false
        let canceller: SimpleCall = {
            isCancelled = true
        }
        let time = DispatchTime.now() + Double(Int64(delayInSeconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: time) {
            () -> Void in
            if !isCancelled {
                block()
            }
        }
        return canceller
    }
    
    public class func onMainThread(after delay:Double = 0, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
    public class func onBackgroundThread(after delay:Double = 0, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.global().asyncAfter(deadline: when, execute: closure)
    }
}
