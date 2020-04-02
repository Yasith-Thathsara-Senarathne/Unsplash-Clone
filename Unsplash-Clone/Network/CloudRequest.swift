//
//  CloudRequest.swift
//  Unsplash-Clone
//
//  Created by Yasith Thathsara Senarathne on 3/31/20.
//  Copyright © 2020 Yasith Thathsara Senarathne. All rights reserved.
//

import MNkCloudRequest

struct CloudRequest {
    struct EndPoints {
        static var root:String {
            return "https://api.unsplash.com/"
        }
        
        static var apiKey:String {
            return "Sm1hRvUdKq4OLSpme7ZmtTvh1gQZ4o9hfOHN2vg6hqU"
        }
        
        static var collections:String {
            return root+"collections"
        }
        
        static var newPhotos:String {
            return root+"photos"
        }
        
        static var randomPhoto:String {
            return root+"photos/random"
        }
    }
    
    static func getCollections(fetched:@escaping(_ collectionList:[Collection]?, _ error:Error?)->()) {
        let urlString = EndPoints.collections
        let param = ["client_id":EndPoints.apiKey]
        MNkCloudRequest.request(urlString,
                                .get,
                                param,
                                [:],
                                .none)
        { (data:[Collection]?, response, error) in
            fetched(data,error)
        }
    }
    
    static func getNewPhotos(fetched:@escaping (_ photoList:[Photo]?, _ error:Error?)->()) {
        let urlString = EndPoints.newPhotos
        let param:[String:Any] = ["client_id":EndPoints.apiKey,
                                  "per_page":30]
        MNkCloudRequest.request(urlString,
                                .get,
                                param,
                                [:],
                                .none)
        { (data:[Photo]?, response, error) in
            fetched(data,error)
        }
    }
    
    static func getRandomPhoto(fetched:@escaping (_ photo:Photo?, _ error:Error?)->()) {
        let urlString = EndPoints.randomPhoto
        let param:[String:Any] = ["client_id":EndPoints.apiKey]
        MNkCloudRequest.request(urlString,
                                .get,
                                param,
                                [:],
                                .none)
        { (data:Photo?, response, error) in
            fetched(data,error)
        }
    }
}
