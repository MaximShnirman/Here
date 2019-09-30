//
//  EndPointType.swift
//  HereMaps
//
//  Created by Maxim Shnirman on 25/09/2019.
//  Copyright © 2019 MaxMan. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var httpTask: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
