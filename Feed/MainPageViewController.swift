//
//  MainPageViewController.swift
//  Feed
//
//  Created by Gregory Zarski on 12/25/16.
//  Copyright © 2016 Gregory Zarski. All rights reserved.
//

import UIKit

class MainPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        self.setViewControllers([(self.storyboard?.instantiateViewController(withIdentifier: "FeedViewController"))!], direction: .forward, animated: false, completion: nil)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if ("FeedViewController" == String(describing: viewController.classForCoder)) {
            return self.storyboard?.instantiateViewController(withIdentifier: "PortalTableViewController")
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if ("PortalTableViewController" == String(describing: type(of: viewController))) {
            return self.storyboard?.instantiateViewController(withIdentifier: "FeedViewController")
        }
        return nil
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
