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
    
    @IBAction func cityButtonTouched(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if (sender.isSelected) {
            hashtagButton.isSelected = false
            hashtagButton.backgroundColor = UIColor.darkText
            sender.backgroundColor = UIColor.lightText
        } else {
            sender.backgroundColor = UIColor.darkText
        }
    }
    
    @IBAction func hashtagButtonTouched(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if (sender.isSelected) {
            cityButton.isSelected = false
            cityButton.backgroundColor = UIColor.darkText
            sender.backgroundColor = UIColor.lightText
        } else {
            sender.backgroundColor = UIColor.darkText
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityButton.setTitleColor(UIColor.lightText, for: UIControlState.normal)
        hashtagButton.setTitleColor(UIColor.lightText, for: UIControlState.normal)
        cityButton.setTitleColor(UIColor.darkText, for: UIControlState.selected)
        hashtagButton.setTitleColor(UIColor.darkText, for: UIControlState.selected)
    }
    
    var currentPost: Post? = nil {
        didSet {
            self.toggleButtons(show: true)
            cityButton?.setTitle(currentPost!.city, for: UIControlState.normal)
            hashtagButton?.setTitle("#" + currentPost!.hashtag, for: UIControlState.normal)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "ShowEmbeddedPostTableView":
                if let ptmvc = segue.destination as? PostTableViewController {
                    ptmvc.parentFeedViewController = self
                }
                break
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
