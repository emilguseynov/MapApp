//
//  MapAnnotation.swift
//  MapApp
//
//  Created by Emil Guseynov on 02.10.2022.
//

import Foundation
import MapKit

class MapAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    let idClient, idClientAccount: Int
    let clientCode: String
    let avatatHash: String?
    let statusOnline: Bool
    
    init(annotationModel: MapAnnotationModel) {
        self.coordinate = CLLocationCoordinate2D(
            latitude: annotationModel.latitude,
            longitude: annotationModel.longitude)
        
        self.idClient = annotationModel.idClient
        self.idClientAccount = annotationModel.idClientAccount
        self.clientCode = annotationModel.clientCode
        self.avatatHash = annotationModel.avatarHash
        self.statusOnline = annotationModel.statusOnline
        
    }
    
}
