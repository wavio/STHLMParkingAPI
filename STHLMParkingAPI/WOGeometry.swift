//
//  Geometry.swift
//  Parkering
//
//  Created by Marvin Nazari on 19/09/15.
//  Copyright © 2015 Marvin Nazari. All rights reserved.
//

public struct WOGeomtry {
    public let type: String
    public let coordinates: [WOCoordinate]
}

public struct WOCoordinate {
    public let longitude: Double
    public let Latitude: Double
}
