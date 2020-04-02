//
//  ProfileURLs.swift
//  Unsplash-Clone
//
//  Created by Yasith Thathsara Senarathne on 4/2/20.
//  Copyright © 2020 Yasith Thathsara Senarathne. All rights reserved.
//

import Foundation

struct ProfileURLs:Decodable {
    var small:URL
    var medium:URL
    var large:URL
    
    private enum CodingKeys:String, CodingKey {
        case small, medium, large
    }
}
