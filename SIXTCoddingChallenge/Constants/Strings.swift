//
//  Strings.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/14/21.
//

import Foundation

public protocol StringKey {
    var rawValue: String { get }
    func get(suffix:String?) -> String
}

extension StringKey {
    public func get(suffix:String? = nil) -> String {
        return (self.rawValue + (suffix ?? "")).localize()
    }
}

extension StringKey {
    typealias Generic = GenericStrings
}

public enum GenericStrings:String, StringKey {
    case ListTabName = "key_list_tab_name"
    case MapTabName = "key_map_tab_name"
    case Name = "key_name"
    case LicensePlate = "key_license_plate"
}

