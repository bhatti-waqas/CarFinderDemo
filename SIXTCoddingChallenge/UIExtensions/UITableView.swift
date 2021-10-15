//
//  UITableView.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/14/21.
//

import UIKit

extension UITableView {
    
    public func dequeue<T>()->T where T:UITableViewCell {
        return self.dequeueReusableCell(withIdentifier: T.cellIdentifier) as! T
    }
    
    public func getCell<T>(at:IndexPath)->T where T:UITableViewCell {
        return self.cellForRow(at: at) as! T
    }
    
    public func dequeue<T>(for indexPath:IndexPath)->T where T:UITableViewCell{
        return self.dequeueReusableCell(withIdentifier: T.cellIdentifier, for: indexPath) as! T
    }
    
    public func registerNibAndDequeue<T>(for indexPath:IndexPath)->T where T:UITableViewCell {
        self.register(T.cellIdentifier.nib(), forCellReuseIdentifier: T.cellIdentifier)
        return self.dequeueReusableCell(withIdentifier: T.cellIdentifier, for: indexPath) as! T
    }
    
    public func registerAndDequeue<T>(for indexPath:IndexPath)->T where T:UITableViewCell {
        self.register(cell: T.self)
        return self.dequeueReusableCell(withIdentifier: T.cellIdentifier, for: indexPath) as! T
    }
    
    public func register<T>(cell: T.Type) where T:UITableViewCell {
        self.register(T.self, forCellReuseIdentifier: T.cellIdentifier)
    }
    
    public func register(_ identifier: String) {
        self.register(identifier.nib(), forCellReuseIdentifier: identifier)
    }
}
