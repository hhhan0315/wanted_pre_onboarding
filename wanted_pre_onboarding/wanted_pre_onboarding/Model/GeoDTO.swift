//
//  GeoResponse.swift
//  wanted_pre_onboarding
//
//  Created by rae on 2022/06/13.
//

import Foundation

struct GeoDTO: Codable {
    let localNames: LocalNames
    let lat: Double
    let lon: Double
    
    enum CodingKeys: String, CodingKey {
        case lat, lon
        case localNames = "local_names"
    }
}

struct LocalNames: Codable {
    let ko: String
}
