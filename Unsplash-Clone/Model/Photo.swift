//
//  Photo.swift
//  Unsplash-Clone
//
//  Created by Yasith Thathsara Senarathne on 4/2/20.
//  Copyright © 2020 Yasith Thathsara Senarathne. All rights reserved.
//

import Foundation

struct Photo:Identifiable, Decodable {
    var id:String
    var urls:URLs
    var user:User
    var likes:Int
    
    private enum CodingKeys:String, CodingKey {
        case id, urls, user, likes
    }
}
