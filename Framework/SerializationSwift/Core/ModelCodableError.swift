//
//  ModelCodableError.swift
//  SerializationSwift
//
//  Created by Rone Loza on 4/20/18.
//  Copyright © 2018 Rone Loza. All rights reserved.
//

open class ModelCodableError : BaseObjectInspectable, Error {
    
    enum ErrorKind {
        case NotMatchingType
        case NotMatchingCodingKey
        case NilValueDecode
        case EmptyDataBytes
        case EmptyDataBytesInObjectFromJsonKey
        case NotDecodeEspecificTypeFromDataBytes
        case NotDecodeFromJsonToFoundation
        case NotMatchingJsonKey
        case JsonToFoundationNoIsObject
        case NotEncounterExpectedType
        case NotOverridingProtocol
    }
    
    let domain = "com.programaniacs.ModelCodableError"
    let code: ErrorKind
    let field: String?
    let message: String?
    
    init(code: ErrorKind, field: String?, message: String?) {
        
        self.code = code
        self.field = field
        self.message = message
    }
}
