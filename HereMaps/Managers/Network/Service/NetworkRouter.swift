//
//  NetworkRouter.swift
//  HereMaps
//
//  Created by Maxim Shnirman on 25/09/2019.
//  Copyright © 2019 MaxMan. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?) -> ()

protocol NetworkRouter {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}
