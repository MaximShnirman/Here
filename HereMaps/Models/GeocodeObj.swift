//
//  GeocodeObj.swift
//  HereMaps
//
//  Created by Maxim Shnirman on 20/09/2019.
//  Copyright © 2019 MaxMan. All rights reserved.
//

import Foundation

// MARK: - Geocode
struct GeocodeObj: Codable {
    let response: Response

    enum CodingKeys: String, CodingKey {
        case response = "Response"
    }
}

// MARK: - Response
struct Response: Codable {
    let metaInfo: MetaInfo
    let view: [View]

    enum CodingKeys: String, CodingKey {
        case metaInfo = "MetaInfo"
        case view = "View"
    }
}

// MARK: - MetaInfo
struct MetaInfo: Codable {
    let timestamp, nextPageInformation: String

    enum CodingKeys: String, CodingKey {
        case timestamp = "Timestamp"
        case nextPageInformation = "NextPageInformation"
    }
}

// MARK: - View
struct View: Codable {
    let type: String
    let viewID: Int
    let result: [Result]

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case viewID = "ViewId"
        case result = "Result"
    }
}

// MARK: - Result
struct Result: Codable {
    let relevance: Int
    let distance: Double
    let matchLevel: String
    let matchQuality: MatchQuality
    let location: Location

    enum CodingKeys: String, CodingKey {
        case relevance = "Relevance"
        case distance = "Distance"
        case matchLevel = "MatchLevel"
        case matchQuality = "MatchQuality"
        case location = "Location"
    }
}

// MARK: - Location
struct Location: Codable {
    let locationID, locationType: String
    let displayPosition: DisplayPosition
    let navigationPosition: [DisplayPosition]
    let mapView: MapView
    let address: Address
    let mapReference: MapReference

    enum CodingKeys: String, CodingKey {
        case locationID = "LocationId"
        case locationType = "LocationType"
        case displayPosition = "DisplayPosition"
        case navigationPosition = "NavigationPosition"
        case mapView = "MapView"
        case address = "Address"
        case mapReference = "MapReference"
    }
}

// MARK: - Address
struct Address: Codable {
    let label, country, state, county: String
    let city, district, street, postalCode: String
    let additionalData: [AdditionalDatum]

    enum CodingKeys: String, CodingKey {
        case label = "Label"
        case country = "Country"
        case state = "State"
        case county = "County"
        case city = "City"
        case district = "District"
        case street = "Street"
        case postalCode = "PostalCode"
        case additionalData = "AdditionalData"
    }
}

// MARK: - AdditionalDatum
struct AdditionalDatum: Codable {
    let value, key: String
}

// MARK: - DisplayPosition
struct DisplayPosition: Codable {
    let latitude, longitude: Double

    enum CodingKeys: String, CodingKey {
        case latitude = "Latitude"
        case longitude = "Longitude"
    }
}

// MARK: - MapReference
struct MapReference: Codable {
    let referenceID, mapID, mapVersion, mapReleaseDate: String
    let spot: Double
    let sideOfStreet, countryID, stateID, countyID: String
    let cityID, districtID: String

    enum CodingKeys: String, CodingKey {
        case referenceID = "ReferenceId"
        case mapID = "MapId"
        case mapVersion = "MapVersion"
        case mapReleaseDate = "MapReleaseDate"
        case spot = "Spot"
        case sideOfStreet = "SideOfStreet"
        case countryID = "CountryId"
        case stateID = "StateId"
        case countyID = "CountyId"
        case cityID = "CityId"
        case districtID = "DistrictId"
    }
}

// MARK: - MapView
struct MapView: Codable {
    let topLeft, bottomRight: DisplayPosition

    enum CodingKeys: String, CodingKey {
        case topLeft = "TopLeft"
        case bottomRight = "BottomRight"
    }
}

// MARK: - MatchQuality
struct MatchQuality: Codable {
    let country, state, county, city: Int
    let district: Int
    let street: [Int]
    let postalCode: Int

    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case state = "State"
        case county = "County"
        case city = "City"
        case district = "District"
        case street = "Street"
        case postalCode = "PostalCode"
    }
}
