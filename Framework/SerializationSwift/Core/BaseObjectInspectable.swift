//
//  BaseModel.swift
//  SerializationSwift
//
//  Created by Rone Loza on 4/18/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation

//CustomStringConvertible
open class BaseObjectInspectable: ObjectInspectable {
    
    public init() {
        
    }
    
    deinit {
        
        #if DEBUG
        print("deinit", NSStringFromClass(type(of: (self as AnyObject))))
        #endif
    }
    
//    var description: String {
//
//        var description = "<\(type(of: self)):"
//
//        for tuple in self.propertiesMetadata() {
//
//            description.append("\n \(tuple.label) = \(tuple.value)")
//        }
//
//        description.append(">")
//
//        return description
//    }

}
