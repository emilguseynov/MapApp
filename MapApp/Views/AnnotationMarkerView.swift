//
//  AnnotationMarkerView.swift
//  MapApp
//
//  Created by Emil Guseynov on 09.10.2022.
//

import Foundation
import UIKit
import MapKit

class AnnotationMarkerView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let annotation = newValue as? MapAnnotation else { return }
            canShowCallout = true
            detailCalloutAccessoryView = CalloutAccessoryView(annotation: annotation)
            markerTintColor = annotation.statusOnline == true ? .green : .red
        }
    }
}
