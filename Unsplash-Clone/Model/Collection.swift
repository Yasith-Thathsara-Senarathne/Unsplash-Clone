//
//  Collection.swift
//  Unsplash-Clone
//
//  Created by Yasith Thathsara Senarathne on 3/31/20.
//  Copyright © 2020 Yasith Thathsara Senarathne. All rights reserved.
//

import Foundation

struct Collection:Identifiable, Decodable {
    var id :Int
    var title:String
    var coverPhoto:CoverPhoto
    
    private enum CodingKeys:String,CodingKey {
        case id, title
        case coverPhoto = "cover_photo"
    }
}
