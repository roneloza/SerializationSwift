//
//  BaseModel.swift
//  SerializationSwift
//
//  Created by rone shender loza aliaga on 4/22/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation

open class BaseModel: BaseObjectInspectable {
    
    public var error: [ModelCodableError]?
    
    public func initialize<E: CodingKey, P: ModelCodable>(from decoder: Decoder,e: E.Type, p: P) {
        
        p.initialize(withDecoder: decoder, codingKeyEnum: E.self, this: p)
    }
}
