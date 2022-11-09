//
//  APIClient.swift
//  ProjectBaseStructure
//
//  Created by Phyo Kyaw Swar on 09/11/2022.
//

import Foundation
import Alamofire
import Combine
import Reachability
import SwiftyJSON
import SystemConfiguration

enum ErrorType : Error {
    case unKnownError
    case internetError
    case knowError(_ message : String)
}

class APIClient {
    static let shared = APIClient()
    private let APIManager: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.urlCache = nil
        configuration.requestCachePolicy = .reloadIgnoringCacheData
        let delegate = Session.default.delegate
        let manager = Session.init(configuration: configuration,
                                   delegate: delegate)
        return manager
    }()
    
    
    
    public func requestCombine<T>(url : String,
                               method : HTTPMethod = .get,
                               parameters : Parameters = [:],
                               headers : HTTPHeaders = [:] ,
                                  model : T.Type) -> AnyPublisher<T?,Error> where T : Decodable {
        
        if !APIClient.checkReachable() {
            return Future<T?,Error> { promise in
                promise(.failure(ErrorType.internetError))
            }.eraseToAnyPublisher()
        }
        
        var headers = headers
        headers["Content-Type"] = "application/json"
        
        
        let encoding : ParameterEncoding = (method == .get ? URLEncoding.default : JSONEncoding.default)
        
        return Future<T?,Error>{ promise in
            
            self.APIManager.request(url, method: method, parameters: parameters,encoding: encoding, headers: headers).responseDecodable(of : model.self , completionHandler: { (response) in
                
                if let data = response.data {
                    promise(.success(data.decode(modelType: model.self)))
                }
                else {
                    let error = ErrorType.unKnownError
                    promise(.failure(error))
                }
               
            })}.eraseToAnyPublisher()
        
    }
}

extension APIClient {
    
    static func isOnline(callback: @escaping (Bool) -> Void){
        //declare this property where it won't go out of scope relative to your listener
        
        let reachability = try! Reachability()
        
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
                callback(true)
            } else {
                print("Reachable via Cellular")
                callback(true)
            }
        }
        
        reachability.whenUnreachable = { _ in
            print("Not reachable")
            callback(false)
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
            callback(false)
        }
    }
    
    static func checkReachable() -> Bool{
        let reachability = SCNetworkReachabilityCreateWithName(nil, "www.raywenderlich.com")
        
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability!, &flags)
        
        if (isNetworkReachable(with: flags))
        {
            if flags.contains(.isWWAN) {
                return true
            }
            
            return true
        }
        else if (!isNetworkReachable(with: flags)) {
            return false
        }
        
        return false
    }
    
    static func checkReachable(success : @escaping () -> Void,
                               failure : @escaping () -> Void){
        
        if checkReachable() {
            success()
        }else{
            failure()
        }
        
    }
    
    static func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutUserInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)
        return isReachable && (!needsConnection || canConnectWithoutUserInteraction)
    }
    
}
