//
//  AllUserLocationResponse.swift
//  RB Tasks
//
//  Created by Hashir Saeed on 12/05/2019.
//  Copyright © 2019 Hashir Saeed. All rights reserved.
//
//
//    AllUserLocationResponse.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper


class AllUserLocationResponse : NSObject, NSCoding, Mappable{
    
    var createdAt : String?
    var email : String?
    var id : Int?
    var lat : Float?
    var lng : Float?
    var updatedAt : String?
    var username : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return AllUserLocationResponse()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        createdAt <- map["createdAt"]
        email <- map["email"]
        id <- map["id"]
        lat <- map["lat"]
        lng <- map["lng"]
        updatedAt <- map["updatedAt"]
        username <- map["username"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        createdAt = aDecoder.decodeObject(forKey: "createdAt") as? String
        email = aDecoder.decodeObject(forKey: "email") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        lat = aDecoder.decodeObject(forKey: "lat") as? Float
        lng = aDecoder.decodeObject(forKey: "lng") as? Float
        updatedAt = aDecoder.decodeObject(forKey: "updatedAt") as? String
        username = aDecoder.decodeObject(forKey: "username") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "createdAt")
        }
        if email != nil{
            aCoder.encode(email, forKey: "email")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if lat != nil{
            aCoder.encode(lat, forKey: "lat")
        }
        if lng != nil{
            aCoder.encode(lng, forKey: "lng")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updatedAt")
        }
        if username != nil{
            aCoder.encode(username, forKey: "username")
        }
        
    }
    
}
