//
//  MapStyle.swift
//  MapApp
//
//  Created by Emil Guseynov on 02.10.2022.
//

import Foundation

struct MapStyle: Decodable {
    let featureType: String?
    let elementType: String
    let stylers: Styler
    
}

struct Styler: Decodable {
    let color: String
}
