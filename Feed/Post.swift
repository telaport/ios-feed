//
//  Post.swift
//  Feed
//
//  Created by Gregory Zarski on 11/28/16.
//  Copyright © 2016 Gregory Zarski. All rights reserved.
//

import Foundation

enum MediaType {
    case image
    case video
}

class Post {
    public let mediaType: MediaType
    public let mediaUrl: String
    public let hashtag: String
    public let city: String
    
    init(mediaType: MediaType, mediaUrl: String, hashtag: String, city: String) {
        self.mediaType = mediaType
        self.mediaUrl = mediaUrl
        self.hashtag = hashtag
        self.city = city
    }
    
    func fetchImage(handler: (Data?) -> Void) {
        if let mediaUrl = URL(string: self.mediaUrl) {
            do {
                let mediaData = try Data(contentsOf: mediaUrl)
                handler(mediaData)
            } catch {
                handler(nil)
            }
        } else {
            handler(nil)
        }
    }
}
