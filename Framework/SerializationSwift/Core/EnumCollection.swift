//
//  EnumCollection.swift
//  SerializationSwift
//
//  Created by Rone Loza on 4/18/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation

public protocol EnumCollection : Hashable {
    
    static func cases() -> AnySequence<Self>
    static var allValues : [Self] { get }
}

extension EnumCollection where Self: RawRepresentable  {
    
    public static func cases() -> AnySequence<Self> {
        
        return AnySequence.init({ () -> AnyIterator<Self> in
            
            var raw = 0
            
            return AnyIterator.init({ () -> Self? in
                
                let current : Self = withUnsafePointer(to: &raw, { (pointer: UnsafePointer<Int>) -> Self in
                    
                    return pointer.withMemoryRebound(to: self, capacity: 1, { (pointerMemoryBound: UnsafePointer<Self>) -> Self in
                        
                        return pointerMemoryBound.pointee
                    })
                })
                
                guard current.hashValue == raw else {
                    return nil
                }
                
                raw += 1
                
                return current;
            })
        })
    }
    
    public static var allValues: [Self] {
        
        return Array(self.cases())
    }
}
