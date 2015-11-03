//
//  ParkingAPI.swift
//  Parkering
//
//  Created by Marvin Nazari on 19/09/15.
//  Copyright © 2015 Marvin Nazari. All rights reserved.
//

import Foundation


public enum WORegulation: String {
    case Servicedagar = "servicedagar"
    case Tillåten = "ptillaten"
    case Buss = "pbuss"
    case Lastbil = "plastbil"
    case Motorcykel = "pmotorcykel"
    case Rörelsehindrad = "prorelsehindrad"
}

public enum WOOperation: String {
    case All = "all"
    case Weekday = "weekday"
    case Area = "area"
    case Street = "street"
    case Within = "within"
    case UntilNextWeekday = "untilNextWeekday"
}

public typealias DefaultResponseCompletionHandler = WOResponse -> Void

public class ParkingAPI {
    
    private let session: NSURLSession
    private let apiKey = "5a447ff5-c0db-44ff-9d27-a190820ae6f9"
    
    public init(session: NSURLSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())) {
        self.session = session
    }
    
    
    public func request(regulation: WORegulation = .Tillåten, streetName name: String, completionHandler: DefaultResponseCompletionHandler?) -> NSURLSessionDataTask {
        return request(operation: .Street, streetName: name, completionHandler: { (response) -> Void in
            completionHandler?(response)
        })
    }
    
    public func request(regulation: WORegulation = .Tillåten, latitude latt: Float, longitude: Float, radius: Float, completionHandler: DefaultResponseCompletionHandler?) -> NSURLSessionDataTask {
        
        return request(regulation, operation: WOOperation.Within, latitude: latt, longitude: longitude, radius: radius, completionHandler: { (response) -> Void in
            completionHandler?(response)
        })

    }
    
    private func request(
        regulation: WORegulation = .Tillåten,
        operation: WOOperation,
        latitude: Float? = nil, longitude: Float? = nil, radius: Float? = nil,
        streetName: String? = nil,
        completionHandler: DefaultResponseCompletionHandler?) -> NSURLSessionDataTask {
            
        
            var path = "\(regulation.rawValue)/\(operation.rawValue)"
            if streetName != nil && latitude == nil && longitude == nil && radius == nil {
                path += "\(streetName!)"
            }
            
            if streetName == nil && latitude != nil && longitude != nil && radius != nil {
                path += "?radius=\(radius!)&lat=\(latitude!)&lng=\(longitude!)"
            }
            
            
        return POST(path) { response in
            completionHandler?(response)
        }
    }
    
    // MARK: Private
    private func POST(path: String, completionHandler: DefaultResponseCompletionHandler?) -> NSURLSessionDataTask {
        
        
        let baseURL: NSURL = NSURL(string: "http://openparking.stockholm.se/LTF-Tolken/v1/\(path)&outputFormat=json&apiKey=\(apiKey)")!
        
        let request = NSMutableURLRequest(URL: baseURL)
                
        request.allHTTPHeaderFields = ["Content-Type": "application/json", "Accept": "application/json"]
        request.HTTPMethod = "GET"
        
        return session.dataTaskWithRequest(request, completionHandler: { (data, HTTPResponse, error) in
            do {                
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                let theResp = try WOResponse.decode(json)
                completionHandler?(theResp)
            } catch {
                print("ERROR DECODING THE RESPONSE \(error)")
            }
            
        })
    }
}
