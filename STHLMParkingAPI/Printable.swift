//
//  Printable.swift
//  STHLMParkingAPI
//
//  Created by Marvin Nazari on 03/11/15.
//  Copyright © 2015 Marvin Nazari. All rights reserved.
//

//MARK: WOVehicle
extension WOVehicle: CustomStringConvertible {
    public var description: String {
        switch self {
        case .Buss:
            return "Buss"
        case .Fordon:
            return "Fordon"
        case .Lastbil:
            return "Lastbil"
        case .Motorcykel:
            return "Motorcykel"
        case .Rorelsehindrade:
            return "Rorelsehindrade"
        }
    }
}
