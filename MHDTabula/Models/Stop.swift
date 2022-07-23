//
//  Stop.swift
//  MHDTabula
//
//  Created by Jakub Jelínek on 23/07/2022.
//

import Foundation

struct Stop: Codable, Identifiable {
    enum CodingKeys: CodingKey {
        case name
        case lat
        case lon
        case value
    }
    let id = UUID()
    let name: String
    let lat: Double
    let lon: Double
    let value: Int
    
    static let example = Stop(name: "Aupark", lat: 48.1319465637207, lon: 17.1085376739502, value: 356)
}
