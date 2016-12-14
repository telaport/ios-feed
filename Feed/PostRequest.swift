//
//  PostRequest.swift
//  Feed
//
//  Created by Gregory Zarski on 11/28/16.
//  Copyright © 2016 Gregory Zarski. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PostRequest {
    var currentOffset = 0
    let limit = 10
    
    public func fetchPosts(handler: @escaping ([Post]) -> Void) {
        let query: Parameters = ["offset": self.currentOffset, "limit": self.limit]
        Alamofire.request("https://api.telaport.me/posts", parameters: query).responseJSON {
            response in
                if let body = response.result.value {
                    let bodyJson = JSON(body)
                    if (bodyJson.array!.count != 0) {
                        var newPosts = [Post]()
                        for (_, newPostJson) in bodyJson {
                            print(newPostJson["hashtagOriginal"])
                            if let hashtag = newPostJson["hashtagOriginal"].string, let mediaUrl = newPostJson["mediaUrl"].string, let city = newPostJson["city"].string {
                                let newPost = Post(mediaType: MediaType.image, mediaUrl: mediaUrl, hashtag: hashtag, city: city)
                                newPosts.append(newPost)
                            }
                        }
                        self.currentOffset = self.currentOffset + bodyJson.array!.count
                        handler(newPosts)
                    }
                }
            }
        
    }
}
