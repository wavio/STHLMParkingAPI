//
//  Decoding.swift
//  STHLMParkingAPI
//
//  Created by Marvin Nazari on 03/11/15.
//  Copyright © 2015 Marvin Nazari. All rights reserved.
//

import Foundation
import Decodable


public enum MetadataError: ErrorType {
    case InvalidJSON
}

//MARK: Response
extension WOResponse: Decodable {
    public static func decode(j: AnyObject) throws -> WOResponse {
        return try WOResponse(
            type: j => "type",
            totalFeatures: j => "totalFeatures",
            features: j => "features"
        )
    }
}

//MARK: Feature
extension WOFeature: Decodable {
    public static func decode(j: AnyObject) throws -> WOFeature {
        return try WOFeature(
            type: j => "type",
            id: j => "id",
            geometryName: j => "geometry_name",
            properties: try j => "properties",
            geometry: j => "geometry"
        )
    }
}

//MARK: LKUserRole
extension WOVehicle: Decodable {
    public static func decode(json: AnyObject) throws -> WOVehicle {
        let string = try String.decode(json)
        guard let role = WOVehicle(rawValue: string) else {
            throw MetadataError.InvalidJSON
        }
        return role
    }
}

//MARK: Property
extension WOProperty: Decodable {
    public static func decode(j: AnyObject) throws -> WOProperty {
        return try WOProperty(
            objectId: j => "FEATURE_OBJECT_ID",
            versionId: j => "FEATURE_VERSION_ID",
            extentNo: j => "EXTENT_NO",
            validFrom: j => "VALID_FROM",
            startTime: try? j => "START_TIME",
            endTime: try? j => "END_TIME",
            startWeekday: try? j => "START_WEEKDAY",
            vehicle: try? j => "VEHICLE",
            citation: try j => "CITATION",
            streetName: try? j => "STREET_NAME",
            cityDistrict: try? j => "CITY_DISTRICT",
            parkingDistrict: try? j => "PARKING_DISTRICT",
            vfMeter: try? j => "VF_METER",
            vgPlatsTyp: try? j => "VF_PLATS_TYP",
            street: try? j => "ADDRESS",
            otherInfo: try? j => "OTHER_INFO",
            maxHours: try? j => "MAX_HOURS",
            dayType: try? j => "DAY_TYPE"
        )
    }
}


//MARK: Geometry
extension WOGeomtry: Decodable {
    public static func decode(j: AnyObject) throws -> WOGeomtry {
        return try WOGeomtry(
            type: j => "type",
            coordinates: j => "coordinates"
        )
    }
}

//MARK: Coordinate
//FIXME: WHAT THE FUCK IS GOING ON HERE!
extension WOCoordinate: Decodable {
    public static func decode(j: AnyObject) throws -> WOCoordinate {
        if let _ = j as? NSArray {
            return WOCoordinate(longitude: j[0] as! Double, Latitude: j[1] as! Double)
        } else {
            throw DecodingError.MissingKey(key: "coordinates", info: DecodingError.Info(object: j))
        }
        
    }
}

