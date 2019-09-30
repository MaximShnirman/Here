//
//  Router.swift
//  HereMaps
//
//  Created by Maxim Shnirman on 29/09/2019.
//  Copyright © 2019 MaxMan. All rights reserved.
//

// reference:
// https://medium.com/flawless-app-stories/writing-network-layer-in-swift-protocol-oriented-approach-4fa40ef1f908

import Foundation

class Router<EndPoint: EndPointType>: NetworkRouter {
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try buildRequest(from: route)
            print("request: \(request)")
            task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                completion(data, response, error)
            })
        } catch {
            completion(nil, nil, error)
        }
        task?.resume()
    }
    
    func cancel() {
        task?.cancel()
    }
    
}

extension Router {
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        request.httpMethod = route.httpMethod.rawValue
        
        do {
            switch route.httpTask {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-type")
                
            case .requestParameters(let bodyParameters, let urlParameters):
                try configureParameters(bodyParameters: bodyParameters,
                                        urlParameters: urlParameters,
                                        request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters, let urlParameters, let additionalParameters):
                additionalHeaders(additionalParameters, request: &request)
                try configureParameters(bodyParameters: bodyParameters,
                                        urlParameters: urlParameters,
                                        request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?, urlParameters: Parameters?, request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        } catch (let exception){
            print("exception: \(exception)")
            throw exception
        }
    }
    
    fileprivate func additionalHeaders(_ additionalParameters: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalParameters else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
