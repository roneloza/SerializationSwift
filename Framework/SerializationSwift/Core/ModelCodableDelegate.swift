//
//  ModelCodableDelegate.swift
//  SerializationSwift
//
//  Created by Rone Loza on 4/18/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation

public typealias TupleCodableType = (value: Codable?, isValid: Bool)

public protocol ModelCodableDelegate {
    
    func getCustomValue<E: CodingKey>(withDecoder decoder: Decoder, codingKeyEnum: E, className: String, propertyName: String) -> TupleCodableType
}

extension ModelCodableDelegate {

    public func getCustomValue<E: CodingKey>(withDecoder decoder: Decoder, codingKeyEnum: E, className: String, propertyName: String) -> TupleCodableType {

        return (nil, false)
    }
}
