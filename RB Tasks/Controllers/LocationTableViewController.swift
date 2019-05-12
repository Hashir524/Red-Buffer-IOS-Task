//
//  LocationTableViewController.swift
//  RB Tasks
//
//  Created by Hashir Saeed on 12/05/2019.
//  Copyright © 2019 Hashir Saeed. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import MBProgressHUD

class LocationTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var userLocationArray : [AllUserLocationResponse] = []
    
    @IBOutlet weak var userLocationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Calling Api
        showProgressIndicator()
        allUserLocationRequest()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userLocationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell" , for: indexPath) as! LocationTableViewCell
        
        if userLocationArray.count != 0 {
           
            cell.usernameTextfield.text = userLocationArray[indexPath.row].username
            cell.locationTextfield.text = "Latitude : \(userLocationArray[indexPath.row].lat!) , Longitude : \(userLocationArray[indexPath.row].lng!)"
        }
        
        
        return cell
        
    }
    
    //OnClick function tableview
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Getting the data from the array and of the specific cell
        print("section: \(indexPath.section)")
        print("row: \(indexPath.row)")
        print("***Name***\(userLocationArray[indexPath.row].username)")
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "mapView") as! MapViewController
        nextViewController.userLocationLat = userLocationArray[indexPath.row].lat!
        nextViewController.userLocationLng = userLocationArray[indexPath.row].lng!
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
        
        
    }
    
    
    //Api Call To Fetch All User Locations
    func allUserLocationRequest()  {
        
        Alamofire.request("http://54.82.176.74:3031/location", method: .get, encoding: JSONEncoding.default)
            .responseArray {(response:
                DataResponse<[AllUserLocationResponse]>) in
                let allUserLocationResponse =  response.result.value
                
                //Assigning Value
                MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                self.userLocationArray = allUserLocationResponse!
                self.userLocationTableView.reloadData()
                
               
        }
        
    }
    
    func showProgressIndicator() {
        
        let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading.."
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
