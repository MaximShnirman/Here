//
//  ParameterEncoding.swift
//  HereMaps
//
//  Created by Maxim Shnirman on 25/09/2019.
//  Copyright © 2019 MaxMan. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]

public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public enum NetworkError: String, Error {
    case parametersNil = "Parameters are nil"
    case encodingFailed = "Parameters encoding failed"
    case missingURL = "URL is nil"
}
