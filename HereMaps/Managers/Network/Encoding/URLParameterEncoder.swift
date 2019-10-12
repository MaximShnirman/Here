//
//  URLParameterEncoder.swift
//  HereMaps
//
//  Created by Maxim Shnirman on 25/09/2019.
//  Copyright © 2019 MaxMan. All rights reserved.
//

import Foundation

public struct URLParameterEncoder: ParameterEncoder {
    
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else {
            Logger.shared.logDebug("no url?")
            throw NetworkError.missingURL
        }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                let quaryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(quaryItem)
            }
            
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-form-url-encoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
}
