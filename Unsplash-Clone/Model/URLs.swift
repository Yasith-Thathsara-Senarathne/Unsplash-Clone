//
//  URLs.swift
//  Unsplash-Clone
//
//  Created by Yasith Thathsara Senarathne on 4/2/20.
//  Copyright © 2020 Yasith Thathsara Senarathne. All rights reserved.
//

import Foundation

struct URLs:Decodable {
    var raw:URL
    var full:URL
    var regular:URL
    var small:URL
    var thumb:URL
    
    private enum CodingKeys:String,CodingKey {
        case raw, full, regular, small, thumb
    }
}
