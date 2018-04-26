//
//  ObjectInspectable.swift
//  SerializationSwift
//
//  Created by Rone Loza on 4/18/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation

import Foundation

public typealias ObjectInspectableType = (label: String, value: Any, type: Any.Type, index: Int)

public protocol ObjectInspectable {
    
    func propertiesMetadata() -> [ObjectInspectableType]
}

extension ObjectInspectable {
    
    public func propertiesMetadata() -> [ObjectInspectableType] {
        
        var index: Int = 0
        return Mirror.init(reflecting: self).children.compactMap {
            
            let value: Any = $0.value
            let type = Mirror.init(reflecting: value).subjectType
            
            let tuple: ObjectInspectableType = ($0.label!, value, type, index)
            
            index += 1
            
            return tuple
        }
    }
}
