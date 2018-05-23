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
import FacebookShare
import FBSDKCoreKit
import FBSDKShareKit
import FBSDKLoginKit

class FinishController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var endLocationManager = CLLocationManager()
    //    @IBOutlet weak var shareonFB: UIButton!
    
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
        //        let loginButton = LoginButton(publishPermissions: [.managePages, .publishPages])
        //        loginButton.frame = CGRect(x: view.frame.width / 4, y: view.frame.height / 2 + 120, width: view.frame.width / 2, height: 50)
        //        view.addSubview(loginButton)
        //        let content = LinkShareContent.init(url: URL)
        //        let shareButton = ShareButton(frame: CGRect(x: view.frame.width / 4, y: view.frame.height / 2 + 120, width: view.frame.width / 2, height: 50), content: content)
        self.endLocationManager = CLLocationManager()
        let startLocation = record.startLocation
        let locValue = record.endLocation
        let sourceLocation = CLLocationCoordinate2D(latitude:startLocation.coordinate.latitude, longitude:startLocation.coordinate.longitude)
        let destinationLocation = CLLocationCoordinate2D(latitude:locValue.coordinate.latitude, longitude:locValue.coordinate.longitude)
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
    
    func endLocationManager(manager: CLLocationManager!,   didUpdateLocations locations: [AnyObject]!) {
        var locValue:CLLocationCoordinate2D = manager.location!.coordinate
    }
    
    
    
    
    //    @IBAction func shareFB(_ sender: Any) {
    //        let content = LinkShareContent.init(url: .init(fileURLWithPath: "https://developers.facebook.com/docs/sharing/ios"))
    //        let shareDialog = ShareDialog(content: content)
    //        shareDialog.mode = .native
    //        shareDialog.failsOnInvalidData = true
    //        shareDialog.completion = { result in
    //            // Handle share results
    //        }
    //
    //
    //        try shareDialog.show()
    
    //        let connection = GraphRequestConnection()
    //        connection.add(GraphRequest(graphPath: "me/feed", parameters: ["message": "text to post on Facebook"], accessToken: AccessToken.current, httpMethod: .POST, apiVersion: .defaultVersion)) { httpResponse, result in
    //            switch result {
    //            case .success(let response):
    //                print("Graph Request Succeeded: \(response)")
    //            case .failed(let error):
    //                print("Graph Request Failed: \(error)")
    //            }
    //        }
    //        connection.start()
    
    //        if FBSDKAccessToken.current().hasGranted("publish_pages") {
    //            publishMessage()
    //        }
    
    //        if (!FBSDKAccessToken.current().hasGranted("publish_to_groups")) {
    //            print("Request publish_to_groups permissions")
    //            requestPublishPermissions()
    //            publishMessage()
    //        }
    //        else {
    //            publishMessage()
    //        }
    //    }
    
    //        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
    //            return // No image selected.
    //        }
    //
    //        let photo = Photo(image: image, userGenerated: true)
    //        let content = PhotoShareContent(photos: [photo])
    //        try ShareDialog.show(from: self, content: content)
    //    }
    
    @IBAction func share(_ sender: Any) {
        print("share")
        let myShare = "Test share"
        // let image: UIImage = UIImage(named: "Home")!
        //let shareVC: UIActivityViewController = UIActivityViewController(activityItems: [myShare, image], applicationActivities: nil)
        let shareVC: UIActivityViewController = UIActivityViewController(activityItems: [myShare], applicationActivities: nil)
        self.present(shareVC, animated: true, completion: nil)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer (overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 4.0
        return renderer
    }
    
    //    func publishMessage()
    //    {
    //        let messageToPost = "test"
    //
    //        if (messageToPost.isEmpty) {
    //            return
    //        }
    //
    //        FBSDKGraphRequest.init(graphPath: "me/feed", parameters: ["message" : messageToPost], httpMethod: "POST").start(completionHandler: { (connection, result, error) -> Void in
    //            if let error = error {
    //                print("Error: \(error)")
    //            } else {
    //                print("Success")
    //                //self.myTextView.text = ""
    //            }
    //        })
    //    }
    //
    //    func requestPublishPermissions()
    //    {
    //        let login: FBSDKLoginManager = FBSDKLoginManager()
    //
    //        login.logIn(withPublishPermissions: ["publish_to_groups"], from: self) { (result, error) in
    //            if (error != nil) {
    //                print(error!)
    //            } else if (result?.isCancelled)! {
    //                print("Canceled")
    //            } else if (result?.grantedPermissions.contains("publish_to_groups"))! {
    //                print("permissions granted")
    //            }
    //        }
    //    }
}
