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
    
    
    fileprivate func mapViewSetup(_ initialLocation: CLLocation) {
        view.addSubview(mapView)
        mapView.frame = view.bounds
        mapView.delegate = self
        mapView.centerToLocation(initialLocation)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialLocation = CLLocation(latitude: 55.75, longitude: 37.61)
        
        mapViewSetup(initialLocation)
        
        loadInitialData()
        
        configureTileOverlay()
        
        
    }
    
    private func configureTileOverlay() {
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
        let urlString = "https://run.mocky.io/v3/96149d36-4ce8-4d4b-a3ac-f937068a1d35"
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, resp, err in
            if let err = err {
                fatalError("error: \(err)")
            }
            do {
                let modelObjects = try JSONDecoder().decode([MapAnnotationModel].self, from: data!)
                let objects = modelObjects.compactMap(MapAnnotation.init)
                self.mapAnnotations.append(contentsOf: objects)
                
                DispatchQueue.main.async {
                    self.mapView.addAnnotations(self.mapAnnotations)
                    self.view.reloadInputViews()
                }
            } catch {
                print("Failed to decode: ", error)
            }
        }.resume()
        
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
}
