//
//  HereEndPoint.swift
//  HereMaps
//
//  Created by Maxim Shnirman on 29/09/2019.
//  Copyright © 2019 MaxMan. All rights reserved.
//

import Foundation
import CoreGraphics

enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum HereApi {
    case reverseGeocode(location: CGPoint)
    case popularPlaces(location: CGPoint)
}

extension HereApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production: return "https://reverse.geocoder.api.here.com/"
        case .qa: return "https://reverse.geocoder.api.here.com/"
        case .staging: return "https://reverse.geocoder.api.here.com/"
        }
    }
    
    var baseURL: URL {
        switch self {
        case .reverseGeocode(_):
            guard let url = URL(string: "https://reverse.geocoder.api.here.com/") else { fatalError("url cannot be configured") }
            return url
        case .popularPlaces(_):
            guard let url = URL(string: "https://places.demo.api.here.com/") else { fatalError("url cannot be configured") }
            return url
        }
//        guard let url = URL(string: environmentBaseURL) else { fatalError("url cannot be configured") }
//        return url
    }
    
    var path: String {
        switch self {
        case .reverseGeocode(_):
            return "6.2/reversegeocode.json"
        case .popularPlaces(_):
            return "places/v1/discover/explore"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .reverseGeocode(_):
            return .get
        case .popularPlaces(_):
            return .get
        }
    }
    
    var httpTask: HTTPTask {
        switch self {
        case .reverseGeocode(let location):
            return HTTPTask.requestParameters(bodyParameters: nil,
                                              urlParameters: ["prox": "\(location.x),\(location.y),250",
                                                              "mode": "retrieveAddresses",
                                                              "maxresults": 1,
                                                              "gen": 9,
                                                              "app_id": NetworkManager.AppID,
                                                              "app_code": NetworkManager.AppCode])
        
           // places/v1/discover/explore?
           // at=52.5159%2C13.3777&
           // cat=sights-museums&
           // app_id=DemoAppId01082013GAL&
           // app_code=AJKnXv84fjrb0KIHawS0Tg
        case .popularPlaces(let location):
            return HTTPTask.requestParameters(bodyParameters: nil,
                                              urlParameters: ["at": "\(location.x),\(location.y)",
                                                              "cat": "sights-museums",
                                                              "app_id": NetworkManager.AppID,
                                                              "app_code": NetworkManager.AppCode])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
