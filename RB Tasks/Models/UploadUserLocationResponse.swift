//
//  UploadUserLocationResponse.swift
//  RB Tasks
//
//  Created by Hashir Saeed on 12/05/2019.
//  Copyright © 2019 Hashir Saeed. All rights reserved.
import Foundation
import ObjectMapper


class UploadUserLocationResponse : NSObject, NSCoding, Mappable{
    
    var createdAt : String?
    var email : String?
    var id : Int?
    var lat : String?
    var lng : String?
    var updatedAt : String?
    var username : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return UploadUserLocationResponse()
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
        lat = aDecoder.decodeObject(forKey: "lat") as? String
        lng = aDecoder.decodeObject(forKey: "lng") as? String
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
