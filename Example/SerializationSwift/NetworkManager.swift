//
//  NetworkManager.swift
//  ShoppingCartWidget
//
//  Created by Rone Loza on 3/28/18.
//  Copyright © 2018 Mambo. All rights reserved.
//

import Foundation
import SerializationSwift

class NetworkManager {
    
    //MARK: - Types -
    
    typealias CompletionNetwork<T> = (ResponseState, T?) -> (Void)
    
    enum ApiPath : String {
        
        case Lookup = "/lookup"
    }
    
    //MARK: - Vars -
    
    private var manager : NetworkManagerProtocol;
    
    //MARK: - Initialization -
    
    private static let sharedNetworkManager : NetworkManager = {
        
        let pardosBaseUrl: URL? = URL.init(string :"https://itunes.apple.com")
        
        let networkManager = NetworkManager.init(baseURL: pardosBaseUrl)
        
        return networkManager
    }()
    
    required init(manager : NetworkManagerProtocol) {
        
        self.manager = manager;
    }
    
    convenience init(baseURL : URL?) {
        
        self.init(manager: NetworkManagerNative.init(baseURL: baseURL))
    }
    
    class func shared() -> NetworkManager {
        
        return sharedNetworkManager;
    }
    
    //MARK: - Setup -
    
    func setManager(manager : NetworkManagerProtocol) {
        
        self.manager = manager
    }
    
    //MARK: - Requets -
    
    func getItunesLookup(identifier :String, completion :CompletionNetwork<LookupMetadata>?) {
        
        self.manager.get(path: ApiPath.Lookup.rawValue, headers: nil, params: ["id" : identifier]) { (state :ResponseState, data: Data?, error: Error?) -> Void in
            
            if let jsonData = data, state == ResponseState.Success {
                
                var error: ModelCodableError? = nil
                if let model: LookupMetadata = LookupMetadata.new(withData: jsonData, error: &error) {
                    
                    completion?(state, model);
                }
                else {
                    
                    completion?(ResponseState.MalFormedData, nil);
                }
            }
            else {
                
                completion?(state, nil);
            }
        }
    }
}
