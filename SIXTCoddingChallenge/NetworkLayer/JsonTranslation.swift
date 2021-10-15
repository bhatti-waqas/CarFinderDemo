//
//  JsonTranslation.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/14/21.
//

import Foundation

public class JSONTranslation: TranslationLayer {
    
    public init(){
        
    }
    public func encode<T>(withModel model: T) throws -> [String : Any] where T : Encodable {
        let encodedData = try JSONEncoder().encode(model)
        if let encoded = try JSONSerialization.jsonObject(with: encodedData, options:.allowFragments) as? [String : Any] {
            return encoded
        }
        throw TranslationLayerError.encodingFailed
    }
    
    public func decode<T>(withData data: Data) throws -> T where T : Decodable {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
