//
//  DashboardViewController.swift
//  RB Tasks
//
//  Created by Hashir Saeed on 10/05/2019.
//  Copyright © 2019 Hashir Saeed. All rights reserved.
//

import UIKit
import GoogleMaps

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var usernameTextfield: UILabel!
    @IBOutlet weak var emailTextfield: UILabel!
    @IBOutlet weak var dbEmailTextfield: UILabel!
    @IBOutlet weak var currentLocationButton: UIButton!
    @IBOutlet weak var AllUserLocationButton: UIButton!
    
    var locationManager = CLLocationManager()

    
    var name : String?
    var email : String?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Getting Values From User Defaults..
        name  = UserDefaults.standard.string(forKey: "name")
        email = UserDefaults.standard.string(forKey: "email")
        print("******Name Coming Gmail******* \(name!)")
        print("******Email Coming Gmail*******\(email!)")
        
        //poupulating UI
        populateUI()
        
        //Rounding Images
        currentLocationButton.layer.cornerRadius = currentLocationButton.frame.height/2
        AllUserLocationButton.layer.cornerRadius = currentLocationButton.frame.height/2
        
    }
    
    func populateUI() {
        emailTextfield.text = email!
        usernameTextfield.text = name!
        dbEmailTextfield.text = UserDefaults.standard.string(forKey: "email")
    }
    
    
    
    @IBAction func currentLocationButtonClick(_ sender: Any)
    {
        //Perform Segue onClick Event
        
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        // 1
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            return
            
        // 2
        case .denied, .restricted:
            let alert = UIAlertController(title: "Location Services disabled", message: "Please enable Location Services in Settings", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)
            return
        case .authorizedAlways, .authorizedWhenInUse:
            //performSegue(withIdentifier: "dashboardToMap", sender: self)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "mapView") as! MapViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)

            print("Already Allowed")
            
    }
    
    }
    
    @IBAction func allUserLocationButtonClick(_ sender: Any) {
        //Perform Action Here.
        
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
