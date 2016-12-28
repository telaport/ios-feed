//
//  Portal.swift
//  Feed
//
//  Created by Gregory Zarski on 12/27/16.
//  Copyright © 2016 Gregory Zarski. All rights reserved.
//

import Foundation

enum PortalType {
    case hashtag // posts with a certain hashtag
    case city // posts created in a certain city
    case user // posts authored by a certain user
    case global // all posts
    case local // local posts
}

class Portal {
    var type: PortalType
    var key: String?
    var text: String
    var imageUrl: String?
    
    init(type: PortalType, key: String?, text: String, imageUrl: String?) {
        self.type = type
        self.key = key
        self.text = text
        self.imageUrl = imageUrl
    }
}
