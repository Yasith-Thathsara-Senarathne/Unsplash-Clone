//
//  User.swift
//  Unsplash-Clone
//
//  Created by Yasith Thathsara Senarathne on 4/2/20.
//  Copyright © 2020 Yasith Thathsara Senarathne. All rights reserved.
//

import Foundation

struct User:Identifiable, Decodable {
    var id:String
    var name:String
    var profileImage:ProfileURLs
    
    private enum CodingKeys:String, CodingKey {
        case id, name
        case profileImage = "profile_image"
    }
}
