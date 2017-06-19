//
//  TabPageViewController.swift
//  DaGithub
//
//  Created by Shalom Shwaitzer on 17/06/2017.
//  Copyright © 2017 Shalom Shwaitzer. All rights reserved.
//

import UIKit
import Material

class TabBarController: PageTabBarController {
    
     var menuButton: IconButton!
     var starButton: IconButton!
     var searchButton: IconButton!
    
    open override func prepare() {
        super.prepare()
        view.backgroundColor = Color.blueGrey.lighten5
        
        delegate = self
        preparePageTabBar()
    }
}

extension TabBarController {
    fileprivate func preparePageTabBar() {
        pageTabBarAlignment = .top
        pageTabBar.dividerColor = nil
        pageTabBar.lineColor = Color.blue.lighten3
        pageTabBar.lineAlignment = .bottom
        pageTabBar.backgroundColor = Color.blue.darken2
    }
}

extension  TabBarController: PageTabBarControllerDelegate {
    func pageTabBarController(pageTabBarController: PageTabBarController, didTransitionTo viewController: UIViewController) {
        print("pageTabBarController", pageTabBarController, "didTransitionTo viewController:", viewController)
    }
}
