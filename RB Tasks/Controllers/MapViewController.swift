//
//  MapViewController.swift
//  RB Tasks
//
//  Created by Hashir Saeed on 10/05/2019.
//  Copyright © 2019 Hashir Saeed. All rights reserved.
//

import UIKit
import GoogleMaps
import AlamofireObjectMapper
import Alamofire
import MBProgressHUD

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    private let locationManager = CLLocationManager()
    var locationUpdated : Bool = true
    
    var userLocationLat : Float?
    var userLocationLng : Float?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if userLocationLat == nil{
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
            
        }else{
            print("User Location is not Nil.. Place a Marker")
            let camera = GMSCameraPosition.camera(withLatitude: Double(userLocationLat!) , longitude:Double(userLocationLng!), zoom:14)
            //showMarker(position: camera.target)
            showCustomMarker(position: camera.target)
            mapView.animate(to: camera)
        }
       
        
    }
    
    //Api
    func uploadUserLocationRequest(parameters: [String: Any]) {
        
        
        Alamofire.request("http://54.82.176.74:3031/location", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseObject {(response:
                DataResponse<UploadUserLocationResponse>) in
                let response =  response.result.value
                print("**** Success ***** Name \(response?.username! ?? "Nil Value")")
                print("**** Success ****** Email \(response?.email ?? "Nil Value")")
                print("**** Success ****** Latitude \(response?.lat ?? "Nil Value")")
                print("**** Success ****** Longitude \(response?.lng ?? "Nil Value")")
                self.displayToast(message: "Location Updated Successfully.")
                
                
        }
    }
    
    func displayToast(message : String) {
        
        let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressHUD.mode = MBProgressHUDMode.text
        progressHUD.detailsLabel.text = message
        progressHUD.margin = 10.0
        progressHUD.offset.y = 150.0
        progressHUD.isUserInteractionEnabled = false
        progressHUD.removeFromSuperViewOnHide = true
        progressHUD.hide(animated: true, afterDelay: 6.0)
    }
    
    func showCustomMarker(position: CLLocationCoordinate2D){
        
        
        let marker = GMSMarker()
        marker.position = position
        //marker.title = title
        marker.icon = UIImage(named: "location_icon")
        marker.map = mapView
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MapViewController: CLLocationManagerDelegate {
    // 2
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // 3
        guard status == .authorizedWhenInUse else {
            return
        }
        // 4
        locationManager.startUpdatingLocation()
        
        //5
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    // 6
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        // 7
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        
        // 8
        locationManager.stopUpdatingLocation()
        
        //Will Only Update The location Once, When the map is loaded
        if locationUpdated {
            
            print("*****Current Location Longitude Latitude****** \(location.coordinate.latitude)")
            print("*****Current Location Longitude Logintude****** \(location.coordinate.longitude)")
            locationUpdated = false
            
            let username = UserDefaults.standard.string(forKey: "name")
            let email = UserDefaults.standard.string(forKey: "email")
            
            let parameters : [String : Any] = [
                
                "username": "\(username!)",
                "email":"\(email!)",
                "lat": "\(location.coordinate.latitude)",
                "lng": "\(location.coordinate.longitude)"
            ]
            
            //Update User Location
            uploadUserLocationRequest(parameters: parameters)
            
        }
        
       
    }
    
    
}



