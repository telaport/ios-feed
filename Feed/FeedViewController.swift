//
//  FeedViewController.swift
//  Feed
//
//  Created by Gregory Zarski on 12/7/16.
//  Copyright © 2016 Gregory Zarski. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    @IBOutlet weak var cityButton: UIButton!
    
    @IBOutlet weak var hashtagButton: UIButton!
    
    var currentPost: Post? = nil {
        didSet {
            self.toggleButtons(show: true)
            cityButton?.setTitle(currentPost!.city, for: UIControlState.normal)
            hashtagButton?.setTitle("#" + currentPost!.hashtag, for: UIControlState.normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "ShowEmbeddedPostTableView":
                if let ptmvc = segue.destination as? PostTableViewController {
                    ptmvc.parentFeedViewController = self
                }
            default:
                break
            }
        }
    }

    func toggleButtons(show: Bool) {
        self.hashtagButton?.isHidden = !show
        self.cityButton?.isHidden = !show
    }

}
