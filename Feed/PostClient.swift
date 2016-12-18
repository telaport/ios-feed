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

class PostClient {
    let limit = 10
    
    public func fetchPosts(filter: (String, String)?, offset: Int, handler: @escaping ([Post]) -> Void) {
        // check if filter key is type city, otherwise plug current location into query parameters
        var query: Parameters = ["offset": offset, "limit": self.limit]
        if let filter = filter {
            let (key, value) = filter
            query[key] = value
        }
        Alamofire.request("https://api.telaport.me/posts", parameters: query).responseJSON {
            response in
                if let body = response.result.value {
                    let bodyJson = JSON(body)
//                    if (bodyJson.array!.count != 0) {
                        var newPosts = [Post]()
                        for (_, newPostJson) in bodyJson {
                            print(newPostJson["hashtagOriginal"])
                            if let hashtag = newPostJson["hashtagOriginal"].string, let mediaUrl = newPostJson["mediaUrl"].string, let city = newPostJson["city"].string {
                                let newPost = Post(mediaType: MediaType.image, mediaUrl: mediaUrl, hashtag: hashtag, city: city)
                                newPosts.append(newPost)
                            }
                        }

                        handler(newPosts)
                    }
//                }
            }
    }
}
