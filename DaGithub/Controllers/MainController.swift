//
//  MainControllers.swift
//  DaGithub
//
//  Created by Shalom Shwaitzer on 17/06/2017.
//  Copyright © 2017 Shalom Shwaitzer. All rights reserved.
//

import Foundation
import UIKit
import Material

class MainController: SnackbarController {
    
    public static weak var instance:MainController?
    
    fileprivate var menuButton: IconButton!
    fileprivate var starButton: IconButton!
    fileprivate var searchButton: IconButton!

    open override func prepare() {
        super.prepare()
        delegate = self
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MainController.instance = self
        
        prepareMenuButton()
        prepareStarButton()
        prepareSearchButton()
        prepareNavigationItem()
    }
    
    fileprivate func prepareMenuButton() {
        menuButton = IconButton(image: Icon.cm.menu, tintColor: .white)
        menuButton.pulseColor = .white
    }
    
    fileprivate func prepareStarButton() {
        starButton = IconButton(image: Icon.cm.star, tintColor: .white)
        starButton.addTarget(self, action: #selector(favoritesButtonTapped), for: .touchUpInside)
        starButton.pulseColor = .white
    }
    
    fileprivate func prepareSearchButton() {
        searchButton = IconButton(image: Icon.cm.search, tintColor: .white)
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        searchButton.pulseColor = .white
    }
    
    fileprivate func prepareNavigationItem() {
        
        
        
        navigationItem.title = "DaGit Trends"
        navigationItem.titleLabel.textColor = .white
        navigationItem.titleLabel.textAlignment = .left
        
        navigationItem.detailLabel.textColor = .white
        navigationItem.detailLabel.textAlignment = .left
        
        navigationItem.leftViews = [menuButton]
        navigationItem.rightViews = [starButton, searchButton]
    }
}

// MARK: - Actions
extension MainController {
    
    @IBAction func favoritesButtonTapped() {
            self.navigationController?.pushViewController(FavoritesViewController(), animated: true)
    }
    
    @IBAction func searchButtonTapped() {
        guard let sb = MainController.instance?.snackbarController else { return }
        sb.snackbar.text = "Search feature has not implemented yet..."
        sb.animate(snackbar: .visible)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            sb.animate(snackbar: .hidden)
        }
    }
}

extension SnackbarController:SnackbarControllerDelegate {
    
}

extension UIViewController {
    
    var navigation:NavigationController? {
        return navigationController as? NavigationController
    }
}
