//
//  TranslationLayer.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/14/21.
//

import Foundation

public enum TranslationLayerError: Error {
    case encodingFailed
}

public protocol TranslationLayer {
    func encode<T:Encodable>(withModel model:T) throws -> [String:Any]
    func decode<T:Decodable>(withData data:Data) throws -> T
}
