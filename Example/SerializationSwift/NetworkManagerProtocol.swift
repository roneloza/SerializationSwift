//
//  MPCNetworkManagerProtocol.swift
//  ShoppingCartWidget
//
//  Created by Rone Loza on 3/28/18.
//  Copyright © 2018 Mambo. All rights reserved.
//

import Foundation

enum ResponseState {
    
    case None
    case Success
    case Error
    case HttpError
    case EmptyData
    case MalFormedData
}

typealias CompletionRequest = (ResponseState, Data?, Error?) -> (Void)

protocol NetworkManagerProtocol {
    
    var baseURL : URL? {get set};
    init(baseURL : URL?)
    
    func get(url :URL, headers :[String : String]?, params :[String : String]?, completion :CompletionRequest?);
    func get(path :String, headers :[String : String]?, params :[String : String]?, completion :CompletionRequest?);
    
    //    func post(url urlRequest:URL, headers:[String : Any]?, params:[String : Any]?, body:[String : Any]?, completion:CompletionNetwork?)
    //    func put(url urlRequest:URL, headers:[String : Any]?, params:[String : Any]?, body:[String : Any]?, completion:CompletionNetwork?)
    //    func patch(url urlRequest:URL, headers:[String : Any]?, params:[String : Any]?, body:[String : Any]?, completion:CompletionNetwork?)
}
