//
//  ViewController.swift
//  MapApp
//
//  Created by Emil Guseynov on 02.10.2022.
//

import UIKit
import MapKit
import MapKitGoogleStyler

class ViewController: UIViewController {

    let mapView = MKMapView()
    private var mapAnnotations: [MapAnnotation] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialLocation = CLLocation(latitude: 55.75, longitude: 37.61)
        
        mapViewSetup(initialLocation)
        loadInitialData()
        configureTileOverlay()
    }
    
    fileprivate func mapViewSetup(_ initialLocation: CLLocation) {
        view.addSubview(mapView)
        mapView.frame = view.bounds
        mapView.delegate = self
        mapView.centerToLocation(initialLocation)
        
        mapView.register(AnnotationMarkerView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.showAnnotations(mapAnnotations, animated: true)
    }
    
    fileprivate func configureTileOverlay() {
        // We first need to have the path of the overlay configuration JSON
        guard let overlayFileURLString = Bundle.main.path(forResource: "overlay", ofType: "json") else {
            return
        }
        let overlayFileURL = URL(fileURLWithPath: overlayFileURLString)
        
        // After that, you can create the tile overlay using MapKitGoogleStyler
        guard let tileOverlay = try? MapKitGoogleStyler.buildOverlay(with: overlayFileURL) else {
            return
        }
        // And finally add it to your MKMapView
        mapView.addOverlay(tileOverlay)
    }
    
    fileprivate func loadInitialData() {
        Service.shared.loadInitialData { mapAnnotations, err in
            self.mapAnnotations.append(contentsOf: mapAnnotations ?? [])
            
            DispatchQueue.main.async {
                self.mapView.addAnnotations(self.mapAnnotations)
                self.view.reloadInputViews()
            }
        }
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        // This is the final step. This code can be copied and pasted into your project
        // without thinking on it so much. It simply instantiates a MKTileOverlayRenderer
        // for displaying the tile overlay.
        if let tileOverlay = overlay as? MKTileOverlay {
            return MKTileOverlayRenderer(tileOverlay: tileOverlay)
        } else {
            return MKOverlayRenderer(overlay: overlay)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        if let annotation = annotation as? MapAnnotation {
          annotationView?.canShowCallout = true
          annotationView?.detailCalloutAccessoryView = CalloutAccessoryView(annotation: annotation)
        }
        return annotationView
      }
    
}
