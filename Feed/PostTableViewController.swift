//
//  PostTableViewController.swift
//  Feed
//
//  Created by Gregory Zarski on 11/28/16.
//  Copyright © 2016 Gregory Zarski. All rights reserved.
//

import UIKit

class PostTableViewController: UITableViewController {
    var parentFeedViewController: FeedViewController? = nil
    var posts = [[Post]]()
    var postClient: PostClient = PostClient()
    var offset: Int {
        get {
            var count = 0
            for section in posts {
                for _ in section {
                    count += 1
                }
            }
            return count
        }
    }
    var filter: (String, String)? {
        didSet {
            self.getPostsFromTheBeginning()
        }
    }
    
    @IBOutlet weak var spinner: UIRefreshControl!
    
    @IBAction func refresh(_ sender: UIRefreshControl) {
        self.getPostsFromTheBeginning()
    }

    func getPostsFromTheBeginning() {
        self.posts = [[Post]]()
        self.postClient.fetchPosts(filter: self.filter, offset: self.offset, handler: {
            (newPosts: [Post]) -> Void in
            DispatchQueue.main.async { () -> Void in
                if (newPosts.count > 0) {
                    self.posts.insert(newPosts, at:0)
                    self.parentFeedViewController?.currentPost = self.posts[0][0]
                    self.tableView.reloadData()
                    self.spinner?.endRefreshing()
                } else {
                    // show no results message
                }
            }
        })
    }
    
    func getMorePosts() {
        // show the bottom spinner
//        self.fetchPosts()
        // append to table view and hide the bottom spinner
    }
    
    
    
//    func getMorePosts() {
//        if self.currentPostRequest != nil {
//            self.currentPostRequest!.fetchPosts{
//                (newPosts: [Post]) -> Void in
//                DispatchQueue.main.async { () -> Void in
//                    if (newPosts.count > 0) {
//                        self.posts.append(newPosts)
//                    }
//                }
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getPostsFromTheBeginning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Post", for: indexPath) as! PostTableViewCell

        let post = posts[indexPath.section][indexPath.row]
        post.fetchImage {
            (data: Data?) -> Void in
            if let data = data {
                cell.mediaImage?.image = UIImage(data: data)
            } else {
                cell.mediaImage?.image = nil
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(UIScreen.main.bounds.height - 20)
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let path = self.tableView.indexPathsForVisibleRows {
            if path.count == 1 {
                let indexPath = path[0]
                self.parentFeedViewController?.currentPost = self.posts[indexPath.section][indexPath.row]
            }
        }
    }
    
    
}