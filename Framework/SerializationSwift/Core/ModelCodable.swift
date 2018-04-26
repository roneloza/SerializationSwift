
//  ModelCodable.swift
//  SerializationSwift
//
//  Created by Rone Loza on 4/18/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

import Foundation

public protocol ModelCodable : Codable, ObjectInspectable, ModelCodableDelegate {
    
    var error: [ModelCodableError]? { get set}
    
    static func new(withData jsonData: Data?, error: inout ModelCodableError?) -> Self?
    static func new(withData jsonData: Data?,key jsonKey: String, error: inout ModelCodableError?) -> Self?
    
    func initialize<E: CodingKey, T:ModelCodable>(withDecoder decoder: Decoder, codingKeyEnum: E.Type, this: T)
    
    func getCodableValue<E: CodingKey, T: Codable>(withDecoder decoder: Decoder, codingKeyEnum: E, type tClass: T.Type) -> T?
    func getCodableValue<E: CodingKey, T: Codable>(withDecoder decoder: Decoder, codingKeyEnum: E, type tClass: T.Type, className: String, propertyName: String) ->  T?
    
    func populate<T>(value: T?, byPropertyName name: String, intoInstance instance: inout Any) -> Void
    
    func populate<E: CodingKey, T: ModelCodable>(withDecoder decoder: Decoder, codingKeyDict: [String:E]?, intoInstance instance: T) -> Void
    
    func populate<E: CodingKey, T: ModelCodable>(withDecoder decoder: Decoder, codingKeyEnum: E, byPropertyName propertyName: String, byClassName className: String, intoInstance instance: T) -> Void
}

extension ModelCodable {
    
    public func initialize<E: CodingKey, T:ModelCodable>(withDecoder decoder: Decoder, codingKeyEnum: E.Type, this: T) {

        var dictKeys: [String:E]? {

            var dict: [String:E] = [:]

            for tuple in self.propertiesMetadata() {

                dict[tuple.label] = E.init(stringValue: tuple.label)
            }

            return (dict.isEmpty ? nil : dict)
        }

        self.populate(withDecoder: decoder, codingKeyDict: dictKeys, intoInstance: this)
    }
    
    public static func decodeCodable(withJsonData jsonData: Data?, error: inout ModelCodableError?) -> Self? {
        
        if let data = jsonData {
            
            if let model: Self = try? JSONDecoder().decode(Self.self, from: data) {
                
                return model
            }
            else {
                
                error = ModelCodableError(code: ModelCodableError.ErrorKind.NotDecodeEspecificTypeFromDataBytes, field: nil, message: nil)
            }
        }
        else {
            
            error = ModelCodableError(code: ModelCodableError.ErrorKind.EmptyDataBytes, field: nil, message: nil)
        }
        
        return nil;
    }
    
    public static func decodeCodable(withJsonData jsonData: Data?, key jsonKey: String, error: inout ModelCodableError?) -> Self? {
        
        if let data = jsonData {
            
            if let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) {
                
                if let root = json as? Dictionary<String, Any?> {
                    
                    if let object = root[jsonKey] as? Dictionary<String, Any?> {
                        
                        if let objectData = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted) {
                            
                            return decodeCodable(withJsonData: objectData, error: &error)
                        }
                        else {
                            
                            error = ModelCodableError(code: ModelCodableError.ErrorKind.EmptyDataBytesInObjectFromJsonKey, field: nil, message: nil)
                        }
                    }
                    else {
                        
                        error = ModelCodableError(code: ModelCodableError.ErrorKind.NotMatchingJsonKey, field: nil, message: nil)
                    }
                }
                else {
                    
                     error = ModelCodableError(code: ModelCodableError.ErrorKind.JsonToFoundationNoIsObject, field: nil, message: nil)
                }
            }
            else {
                
                error = ModelCodableError(code: ModelCodableError.ErrorKind.NotDecodeFromJsonToFoundation, field: nil, message: nil)
            }
        }
        else {
            
            error = ModelCodableError(code: ModelCodableError.ErrorKind.EmptyDataBytes, field: nil, message: nil)
        }
        
        return nil;
    }
    
    public static func new(withData jsonData: Data?, error: inout ModelCodableError?) -> Self? {
        
        if let model = decodeCodable(withJsonData: jsonData, error: &error) {
            
            return model
        }
        
        return nil
    }
    
    public static func new(withData jsonData: Data?,key jsonKey: String, error: inout ModelCodableError?) -> Self? {
        
        if let model = decodeCodable(withJsonData: jsonData, key: jsonKey, error: &error) {
            
            return model
        }
        
        return nil
    }
    
    public func getCodableValue<E: CodingKey, T: Codable>(withDecoder decoder: Decoder, codingKeyEnum: E, type tClass: T.Type) -> T? {
        
        if let container = try? decoder.container(keyedBy: E.self) {
            
            if let object = try? container.decode(T.self, forKey: codingKeyEnum){
                
                return object
            }
            else {
                
                self.addError(ModelCodableError(code: ModelCodableError.ErrorKind.NilValueDecode,field: nil, message: nil))
            }
        }
        else {
            
            self.addError(ModelCodableError(code: ModelCodableError.ErrorKind.NotMatchingCodingKey, field: nil, message: nil))
        }
        
        return nil
    }
    
    func addError(_ error: ModelCodableError) {
    
        var this = self
        
        if (this.error == nil) {

            this.error = []
        }
        
        this.error?.append(error)
    }
    
    public func getCodableValue<E: CodingKey, T: Codable>(withDecoder decoder: Decoder, codingKeyEnum: E, type tClass: T.Type, className: String, propertyName: String) ->  T? {
        
        if (className == String(describing: T.self)) {
            
            if let container = try? decoder.container(keyedBy: E.self) {
                
                if let object = try? container.decode(T.self, forKey: codingKeyEnum){
                    
                    return object
                }
                else {
                    
                    self.addError(ModelCodableError(code: ModelCodableError.ErrorKind.NilValueDecode, field: propertyName, message: nil))
                }
            }
            else {
                
                self.addError(ModelCodableError(code: ModelCodableError.ErrorKind.NotMatchingCodingKey, field: propertyName, message: nil))
            }
        }
        else {
            
            self.addError(ModelCodableError(code: ModelCodableError.ErrorKind.NotMatchingType, field: propertyName, message: nil))
        }
        
        return nil
    }
    
    func address(o: UnsafeRawPointer) -> Int {
        //        return unsafeBitCast(o, to: Int.self)
        return  Int.init(bitPattern: o)
    }
    
    func addressHeap<T: AnyObject>(o: T) -> Int {
        return unsafeBitCast(o, to: Int.self)
    }
    
    public func populate<T>(value byVal: T?, byPropertyName name: String, intoInstance instance: inout Any) {
        
        guard let namePointer = NSString(string: name).utf8String,
            let ivar = class_getInstanceVariable(type(of: (instance as AnyObject)), namePointer),
            let value = byVal
            //,let ivarNameC = ivar_getName(ivar)
            else {
                
                return
        }
        
        let fieldOffset = ivar_getOffset(ivar)
        //        let ivarName = String(cString: ivarNameC)
        
        //        print("setting value for property \(ivarName) into instance \(instance.classForCoder), offset is \(fieldOffset)")
        
        //        object_setIvar(instance, ivar, value)
        
        let addressOf = self.addressHeap(o: (instance as AnyObject))
        
        // 1
        //        withUnsafePointer(to: &instance) { pointer in
        // 2
        if let base = UnsafeRawPointer.init(bitPattern: addressOf) {
            // 3
            let rawBPointer = base.advanced(by: fieldOffset)
            // 4
            let b = rawBPointer.bindMemory(to: T.self, capacity: 1)
            // 5
            let mutable = UnsafeMutablePointer<T>(mutating: b)
            
            mutable.initialize(to: value)
            //            mutable.pointee = value
            //            mutable.deinitialize(count: 1)
        }
        //        }
        
        //        withUnsafeMutablePointer(to: &instance) { (pointer) -> Void in
        
        //            MemoryLayout<Self>.size      // returns 8 (on 64-bit)
        //            MemoryLayout<Self>.stride    // returns 8 (on 64-bit)
        //            MemoryLayout<Self>.alignment
        
        //            let pointerToField = UnsafeMutablePointer<Any>(pointer + 32)
        //            pointerToField.initialize(to: value)
        //            pointerToField.pointee = value as AnyObject
        
        //            let ptrBase = UnsafeRawPointer(pointer)
        //            let rawFieldPointer = ptrBase.advanced(by: 32)
        //            let rawFieldTypePointer = rawFieldPointer.bindMemory(to: String?.self, capacity: 1)
        //            let mutable = UnsafeMutablePointer<String?>(mutating: rawFieldTypePointer)
        
        //            mutable.initialize{(to: (value as? String))
        //            mutable.pointee = (value as? String)
        //            mutable.deinitialize(count: 1)
        
        //            rawFieldTypePointer.deallocate()
        
        //            (pointer.pointee as? ShoppingCart)?.identifier = value as? String
        
        //            let ptr = UnsafeMutablePointer<Any>(32)
        
        //            let pointerToField  = pointer.advanced(by: fieldOffset)
        //            let pointerToField = UnsafeMutablePointer<Any>(pointer + 32)
        //            pointerToField.initialize(to: value)
        //            pointerToField.pointee = value
        //            pointerToField.deinitialize(count: 1)
        //            print("pointee now has value \(mutable.pointee)")
        //        }
    }
    
    public func populate<E: CodingKey, T: ModelCodable>(withDecoder decoder: Decoder, codingKeyDict: [String:E]?, intoInstance instance: T) -> Void {

        for tuple in self.propertiesMetadata() {

            if let dict = codingKeyDict, let codingkey = dict[tuple.label] {

                let className = String(describing: type(of: tuple.value))

                self.populate(withDecoder: decoder, codingKeyEnum: codingkey, byPropertyName: tuple.label, byClassName: className, intoInstance: instance)
            }
        }
    }
    
    public func populate<E: CodingKey, T: ModelCodable>(withDecoder decoder: Decoder, codingKeyEnum: E, byPropertyName propertyName: String, byClassName className: String, intoInstance instance: T) -> Void {
        
        var this = self as Any
        
        if className == String(describing: String?.self) {
            let value = self.getCodableValue(withDecoder: decoder, codingKeyEnum: codingKeyEnum, type: String?.self, className: className, propertyName: propertyName)
            self.populate(value: value, byPropertyName: propertyName, intoInstance: &this)
        }
        else if className == String(describing: String.self) {
            let value = self.getCodableValue(withDecoder: decoder, codingKeyEnum: codingKeyEnum, type: String.self, className: className, propertyName: propertyName)
            self.populate(value: value, byPropertyName: propertyName, intoInstance: &this)
        }
        else if className == String(describing: Int?.self) {
            let value = self.getCodableValue(withDecoder: decoder, codingKeyEnum: codingKeyEnum, type: Int?.self, className: className, propertyName: propertyName)
            self.populate(value: value, byPropertyName: propertyName, intoInstance: &this)
        }
        else if className == String(describing: Int.self) {
            let value = self.getCodableValue(withDecoder: decoder, codingKeyEnum: codingKeyEnum, type: Int.self, className: className, propertyName: propertyName)
            self.populate(value: value, byPropertyName: propertyName, intoInstance: &this)
        }
        else if className == String(describing: UInt?.self) {
            let value = self.getCodableValue(withDecoder: decoder, codingKeyEnum: codingKeyEnum, type: UInt?.self, className: className, propertyName: propertyName)
            self.populate(value: value, byPropertyName: propertyName, intoInstance: &this)
        }
        else if className == String(describing: UInt.self) {
            let value = self.getCodableValue(withDecoder: decoder, codingKeyEnum: codingKeyEnum, type: UInt.self, className: className, propertyName: propertyName)
            self.populate(value: value, byPropertyName: propertyName, intoInstance: &this)
        }
        else if className == String(describing: Double?.self) {
            let value = self.getCodableValue(withDecoder: decoder, codingKeyEnum: codingKeyEnum, type: Double?.self, className: className, propertyName: propertyName)
            self.populate(value: value, byPropertyName: propertyName, intoInstance: &this)
        }
        else if className == String(describing: Double.self) {
            let value = self.getCodableValue(withDecoder: decoder, codingKeyEnum: codingKeyEnum, type: Double.self, className: className, propertyName: propertyName)
            self.populate(value: value, byPropertyName: propertyName, intoInstance: &this)
        }
        else if className == String(describing: Float?.self) {
            let value = self.getCodableValue(withDecoder: decoder, codingKeyEnum: codingKeyEnum, type: Float?.self, className: className, propertyName: propertyName)
            self.populate(value: value, byPropertyName: propertyName, intoInstance: &this)
        }
        else if className == String(describing: Float.self) {
            let value = self.getCodableValue(withDecoder: decoder, codingKeyEnum: codingKeyEnum, type: Float.self, className: className, propertyName: propertyName)
            self.populate(value: value, byPropertyName: propertyName, intoInstance: &this)
        }
        else if className == String(describing: Bool?.self) {
            let value = self.getCodableValue(withDecoder: decoder, codingKeyEnum: codingKeyEnum, type: Bool?.self, className: className, propertyName: propertyName)
            self.populate(value: value, byPropertyName: propertyName, intoInstance: &this)
        }
        else if className == String(describing: Bool.self) {
            let value = self.getCodableValue(withDecoder: decoder, codingKeyEnum: codingKeyEnum, type: Bool.self, className: className, propertyName: propertyName)
            self.populate(value: value, byPropertyName: propertyName, intoInstance: &this)
        }
        else if className == String(describing: [String].self) {
            let value = self.getCodableValue(withDecoder: decoder, codingKeyEnum: codingKeyEnum, type: [String].self, className: className, propertyName: propertyName)
            self.populate(value: value, byPropertyName: propertyName, intoInstance: &this)
        }
        else if className == String(describing: [String]?.self) {
            let value = self.getCodableValue(withDecoder: decoder, codingKeyEnum: codingKeyEnum, type: [String]?.self, className: className, propertyName: propertyName)
            self.populate(value: value, byPropertyName: propertyName, intoInstance: &this)
        }
        else if className == String(describing: [Int].self) {
            let value = self.getCodableValue(withDecoder: decoder, codingKeyEnum: codingKeyEnum, type: [Int].self, className: className, propertyName: propertyName)
            self.populate(value: value, byPropertyName: propertyName, intoInstance: &this)
        }
        else if className == String(describing: [Int]?.self) {
            let value = self.getCodableValue(withDecoder: decoder, codingKeyEnum: codingKeyEnum, type: [Int]?.self, className: className, propertyName: propertyName)
            self.populate(value: value, byPropertyName: propertyName, intoInstance: &this)
        }
        else if className ==  String(describing: [UInt].self) {
            let value = self.getCodableValue(withDecoder: decoder, codingKeyEnum: codingKeyEnum, type: [UInt].self, className: className, propertyName: propertyName)
            self.populate(value: value, byPropertyName: propertyName, intoInstance: &this)
        }
        else if className ==  String(describing: [UInt]?.self) {
            let value = self.getCodableValue(withDecoder: decoder, codingKeyEnum: codingKeyEnum, type: [UInt]?.self, className: className, propertyName: propertyName)
            self.populate(value: value, byPropertyName: propertyName, intoInstance: &this)
        }
        else if className ==  String(describing: [Double].self) {
            let value = self.getCodableValue(withDecoder: decoder, codingKeyEnum: codingKeyEnum, type: [Double].self, className: className, propertyName: propertyName)
            self.populate(value: value, byPropertyName: propertyName, intoInstance: &this)
        }
        else if className ==  String(describing: [Double]?.self) {
            let value = self.getCodableValue(withDecoder: decoder, codingKeyEnum: codingKeyEnum, type: [Double]?.self, className: className, propertyName: propertyName)
            self.populate(value: value, byPropertyName: propertyName, intoInstance: &this)
        }
        else if className ==  String(describing: [Float].self) {
            let value = self.getCodableValue(withDecoder: decoder, codingKeyEnum: codingKeyEnum, type: [Float].self, className: className, propertyName: propertyName)
            self.populate(value: value, byPropertyName: propertyName, intoInstance: &this)
        }
        else if className ==  String(describing: [Float]?.self) {
            let value = self.getCodableValue(withDecoder: decoder, codingKeyEnum: codingKeyEnum, type: [Float]?.self, className: className, propertyName: propertyName)
            self.populate(value: value, byPropertyName: propertyName, intoInstance: &this)
        }
        else if className ==  String(describing: [Bool].self) {
            let value = self.getCodableValue(withDecoder: decoder, codingKeyEnum: codingKeyEnum, type: [Bool].self, className: className, propertyName: propertyName)
            self.populate(value: value, byPropertyName: propertyName, intoInstance: &this)
        }
        else if className ==  String(describing: [Bool]?.self) {
            let value = self.getCodableValue(withDecoder: decoder, codingKeyEnum: codingKeyEnum, type: [Bool]?.self, className: className, propertyName: propertyName)
            self.populate(value: value, byPropertyName: propertyName, intoInstance: &this)
        }
        else {
         
            let value = self.getCustomValue(withDecoder: decoder, codingKeyEnum: codingKeyEnum, className: className, propertyName: propertyName)
            
            if (value.isValid) {
             
                self.populate(value: value.value, byPropertyName: propertyName, intoInstance: &this)
            }
            else {
                
                self.addError(ModelCodableError(code: ModelCodableError.ErrorKind.NotEncounterExpectedType,field: propertyName, message: nil))
            }
        }
    }
}
