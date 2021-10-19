//
//  Int.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/14/21.
//

import Foundation

public extension Int {
    func toString()->String {
        return String(self)
    }
}

public extension Double {
    func toString() -> String {
        return String(format: "%f", self)
    }
}
