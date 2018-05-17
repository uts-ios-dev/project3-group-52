//
//  FinishController.swift
//  Insist
//
//  Created by Jinmiao Cheng on 16/5/18.
//  Copyright © 2018 Shiwei Lin. All rights reserved.
//

import UIKit
import MapKit

class FinishController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    class customPin: NSObject,MKAnnotation {
        var coordinate: CLLocationCoordinate2D
        var title: String?
        var subtitle: String?
        
        init(pinTitle:String, pinSubTitle:String, location:CLLocationCoordinate2D) {
            self.title = pinTitle
            self.coordinate = location
            self.subtitle = pinSubTitle
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sourceLocation = CLLocationCoordinate2D(latitude:-33.923164, longitude:151.18543)
        let destinationLocation = CLLocationCoordinate2D(latitude:-33.883238, longitude:151.200494)
        let sourcePin = customPin(pinTitle: "Mascot", pinSubTitle: "Home", location: sourceLocation)
        let destinationPin = customPin(pinTitle: "Ultimo", pinSubTitle: "UTS", location: destinationLocation)
        self.mapView.addAnnotation(sourcePin)
        self.mapView.addAnnotation(destinationPin)
        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation)
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
        directionRequest.transportType = .walking
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate{(response, error) in
            guard let directionResonse = response else {
                if let error = error {
                    print("we have error getting destination==\(error.localizedDescription)")
                }
                return
            }
            let route = directionResonse.routes[0]
            self.mapView.add(route.polyline, level: .aboveRoads)
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
        self.mapView.delegate = self
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer (overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 4.0
        return renderer
    }
    
    
}
