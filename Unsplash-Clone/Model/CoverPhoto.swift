//
//  CoverPhoto.swift
//  Unsplash-Clone
//
//  Created by Yasith Thathsara Senarathne on 4/2/20.
//  Copyright © 2020 Yasith Thathsara Senarathne. All rights reserved.
//

import Foundation

struct CoverPhoto:Identifiable, Decodable {
    var id:String
    var urls:URLs
    
    private enum CodingKeys:String,CodingKey {
        case id, urls
    }
}
