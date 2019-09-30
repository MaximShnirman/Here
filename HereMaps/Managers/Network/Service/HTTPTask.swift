//
//  HTTPTask.swift
//  HereMaps
//
//  Created by Maxim Shnirman on 25/09/2019.
//  Copyright © 2019 MaxMan. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPTask {
    case request
    case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
    case requestParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionalParameters: HTTPHeaders?)
}
