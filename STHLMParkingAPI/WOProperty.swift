//
//  Property.swift
//  Parkering
//
//  Created by Marvin Nazari on 19/09/15.
//  Copyright © 2015 Marvin Nazari. All rights reserved.
//

public enum WOVehicle: String {
    case Motorcykel = "motorcykel"
    case Rorelsehindrade = "rörelsehindrade"
    case Fordon = "fordon"
    case Buss = "buss"
    case Lastbil = "lastbil"
}

public struct WOProperty {
    public let objectId: Int
    public let versionId: Int
    public let extentNo: Int
    public let validFrom: String
    public let startTime: String?
    public let endTime: String?
    public let startWeekday: String?
    public let vehicle: WOVehicle?
    public let citation: String
    public let streetName: String?
    public let cityDistrict: String?
    public let parkingDistrict: String?
    public let vfMeter: String?
    public let vgPlatsTyp: String?
    public let street: String?
    public let otherInfo: String?
    public let maxHours: String?
    public let dayType: String?
}
