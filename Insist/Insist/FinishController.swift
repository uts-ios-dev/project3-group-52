//
//  FinishController.swift
//  Insist
//
//  Created by Jinmiao Cheng on 16/5/18.
//  Copyright © 2018 Shiwei Lin. All rights reserved.
//

import UIKit
import MapKit
import FacebookLogin
import FacebookCore
import FBSDKCoreKit
import FBSDKLoginKit

class FinishController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var endLocationManager = CLLocationManager()
    
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
    
    //set the map route
    override func viewDidLoad() {
        super.viewDidLoad()
        let startLocation = record.startLocation
        let endLocation = record.endLocation
        print(startLocation)
        print(endLocation)
        
        let sourceLocation = CLLocationCoordinate2D(latitude: startLocation.coordinate.latitude, longitude: startLocation.coordinate.longitude)
        let destinationLocation = CLLocationCoordinate2D(latitude: endLocation.coordinate.latitude, longitude: endLocation.coordinate.longitude)
        let sourcePin = customPin(pinTitle: "Start", pinSubTitle: "Start point", location: sourceLocation)
        let destinationPin = customPin(pinTitle: "End", pinSubTitle: "End point", location: destinationLocation)
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
    
    //share the record information by share button
    @IBAction func share(_ sender: Any) {
        print("share")
        let insistShare = "Share by Insist (\(record.date)): \(user.username) ran \(record.distance) today!"
        // let image: UIImage = UIImage(named: "Home")!
        //let shareVC: UIActivityViewController = UIActivityViewController(activityItems: [myShare, image], applicationActivities: nil)
        let shareVC: UIActivityViewController = UIActivityViewController(activityItems: [insistShare], applicationActivities: nil)
        self.present(shareVC, animated: true, completion: nil)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer (overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 4.0
        return renderer
    }
}
