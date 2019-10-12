//
//  NetworkManager.swift
//  HereMaps
//
//  Created by Maxim Shnirman on 29/09/2019.
//  Copyright © 2019 MaxMan. All rights reserved.
//

import Foundation
import CoreGraphics

enum NetworkResponse: String, Error {
    case success
    case authenticatedUser = "You need to be authenticated user"
    case badRequest = "Bad request"
    case outdated = "The requested URL is outdated"
    case failed = "Network request failed"
    case noData = "Response returned with no data to decode"
    case unableToDecode = "We could not decode the response"
}

fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Swift.Result<String, NetworkResponse> {
    print("status code: \(response.statusCode)")
    switch response.statusCode {
    case 200...299: return .success(NetworkResponse.success.rawValue)
    case 401...500: return .failure(NetworkResponse.authenticatedUser)
    case 501...599: return .failure(NetworkResponse.badRequest)
    case 600: return .failure(NetworkResponse.outdated)
    default: return .failure(NetworkResponse.failed)
    }
}

struct NetworkManager {
    static let environment: NetworkEnvironment = .qa
    static let AppID: String = "pkrMIoyrqrbLBiWZ3dPP"
    static let AppCode: String = "IhJ_lGOjgyETH1-ceIzxnA"
    private let router: Router = Router<HereApi>()
}

extension NetworkManager {
    
    private func networkResponse<T: Codable>(_ data: Data?,_ response: URLResponse?,_ error: Error?,_ completion: @escaping (_ obj: T?, _ error: Error?) -> ()) {
        if error != nil {
            print("error: \(String(describing: error))")
            completion(nil, error)
        }
        
        if let response = response as? HTTPURLResponse {
            let result = handleNetworkResponse(response)
            switch result {
            case .success(_):
                guard let responseData = data else {
                    print("no data?")
                    completion(nil, NetworkResponse.noData)
                    return
                }
                do {
                    let apiResponse = try JSONDecoder().decode(T.self, from: responseData)
                    print("success: \(apiResponse)")
                    completion(apiResponse, nil)
                } catch (let exception) {
                    print("exception: \(exception)")
                    completion(nil, NetworkResponse.unableToDecode)
                }
            case .failure(let networkFailError):
                print("failure: \(networkFailError)")
                completion(nil, networkFailError)
            }
        } else {
            print("failed to unwrrap response as? HTTPURLResponse")
        }
    }
    
    func getReverseGeocode(location: CGPoint, completion: @escaping (_ mapObject: GeocodeObj?, _ error: Error?) -> ()) {
        router.request(.reverseGeocode(location: location)) { (data, response, error) in
            self.networkResponse(data, response, error, completion)
        }
    }
    
    func getPlaces(location: CGPoint, completion: @escaping (_ places: PlacesModel.Places?, _ error: Error?) -> ()) {
        router.request(.popularPlaces(location: location)) { (data, response, error) in
            self.networkResponse(data, response, error, completion)
        }
    }
}
