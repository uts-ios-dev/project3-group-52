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

class FinishController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
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
        
<<<<<<< HEAD
<<<<<<< HEAD
        let sourceLocation = record.startLocation
        let destinationLocation = record.endLocation
        let sourcePin = customPin(pinTitle: "Start", pinSubTitle: "Start point", location: sourceLocation)
        let destinationPin = customPin(pinTitle: "End", pinSubTitle: "End point", location: destinationLocation)
=======
=======
>>>>>>> f9754285ac67ce247997fa9addd03fca171679d2
        let sourceLocation = CLLocationCoordinate2D(latitude:-33.923164, longitude:151.18543)
        let destinationLocation = CLLocationCoordinate2D(latitude:-33.883238, longitude:151.200494)
        let sourcePin = customPin(pinTitle: "Mascot", pinSubTitle: "Home", location: sourceLocation)
        let destinationPin = customPin(pinTitle: "Ultimo", pinSubTitle: "UTS", location: destinationLocation)
<<<<<<< HEAD
>>>>>>> f9754285ac67ce247997fa9addd03fca171679d2
=======
>>>>>>> f9754285ac67ce247997fa9addd03fca171679d2
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
    
<<<<<<< HEAD
<<<<<<< HEAD
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        //        print("locations = \(locValue.latitude) \(locValue.longitude)")
        let location = locations.last! as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        record.endLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.075, longitudeDelta: 0.075))
        
        self.mapView.setRegion(region, animated: true)
        }
    
    
        func shareFB(_ sender: Any) {
=======
//    @IBAction func shareFB(_ sender: Any) {
>>>>>>> f9754285ac67ce247997fa9addd03fca171679d2
=======
//    @IBAction func shareFB(_ sender: Any) {
>>>>>>> f9754285ac67ce247997fa9addd03fca171679d2
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
