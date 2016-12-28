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
    public var mediaData: Data?
    
    init(mediaType: MediaType, mediaUrl: String, hashtag: String, city: String) {
        self.mediaType = mediaType
        self.mediaUrl = mediaUrl
        self.hashtag = hashtag
        self.city = city
        self.mediaData = nil
    }
    
    func fetchImage(handler: @escaping (Data?) -> Void) {
        if let mediaData = self.mediaData {
            // we already have the mediaData, let's just call the handler.
            handler(mediaData)
        } else {
            // we don't have the mediaData and need to fetch it.
            DispatchQueue.global(qos: .userInteractive).async { () -> Void in
                if let mediaUrl = URL(string: self.mediaUrl) {
                    do {
                        self.mediaData = try Data(contentsOf: mediaUrl)
                        handler(self.mediaData)
                    } catch {
                        handler(nil)
                    }
                } else {
                    handler(nil)
                }
            }
        }
    }
}
