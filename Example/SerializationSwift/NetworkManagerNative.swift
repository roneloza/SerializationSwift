
//
//  MPCNetworkManagerNative.swift
//  ShoppingCartWidget
//
//  Created by Rone Loza on 3/28/18.
//  Copyright © 2018 Mambo. All rights reserved.
//

import Foundation

class NetworkManagerNative : NetworkManagerProtocol {
    var baseURL: URL?
    
    // MARK: - Types -
    
    enum RequestType {
        case GET
        case POST
        case PUT
        case PATCH
    }
    
    private let session: URLSession;
    
    func setHeaders(request :inout URLRequest, headers: [String : String]?) {
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/vnd.pardos.v1+json", forHTTPHeaderField: "Accept")
        
        if let headerFields = headers {
            
            for (key, value) in headerFields {
                
                request.setValue(value, forHTTPHeaderField:key)
            }
        }
    }
    
    func makeRequest(url :URL, type:RequestType = RequestType.GET, headers: [String : String]?) -> URLRequest {
        
        var request = URLRequest.init(url: url);
        
        self.setHeaders(request: &request, headers: headers)
        
        return request;
    }
    
    func makeURL(url: URL, params: [String: String]?) -> URL {
        
        var urlComponents = URLComponents.init(url: url, resolvingAgainstBaseURL: true)
        
        // add params
        
        if let params = params {
            
            var queries : [URLQueryItem]? = []
            
            for (key, value) in params {
                
                let query = URLQueryItem(name: key, value: value)
                queries?.append(query)
            }
            
            urlComponents?.queryItems = queries
        }
        
        return urlComponents?.url ?? url
    }
    
    func resolveState(data :Data?, response :URLResponse?, error:Error?) -> ResponseState {
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
            
            if (error != nil) {
                
                return ResponseState.Error;
            }
            else if (data == nil) {
                
                return ResponseState.EmptyData;
            }
            else {
                
                return ResponseState.Success;
            }
            
        } else {
            
            return ResponseState.HttpError
        }
    }
    
    // MARK: - MPCNetworkManagerProtocol -
    
    required init(baseURL: URL?) {
        
        self.baseURL = baseURL
        self.session = URLSession(configuration: .default);
    }
    
    func get(url: URL, headers: [String : String]?, params: [String : String]?, completion: CompletionRequest?) {
        
        let customUrl = self.makeURL(url: url, params: params)
        
        let request = self.makeRequest(url: customUrl, headers: headers)
        
        self.session.dataTask(with :request) { (data :Data?, response :URLResponse?, error:Error?) in
            
            if let block = completion {
                
                let state = self.resolveState(data: data, response: response, error: error)
                
                block(state, data, error);
            }
            }.resume()
    }
    
    func get(path: String, headers: [String : String]?, params: [String : String]?, completion: CompletionRequest?) {
        
        if let url = self.baseURL {
            
            let requestUrl : URL! = URL.init(string: path, relativeTo: url)
            
            self.get(url: requestUrl, headers: headers, params: params, completion: completion)
        }
    }
}
