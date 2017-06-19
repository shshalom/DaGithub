//  ReposViewController.swift
//  DaGithub
//
//  Created by Shalom Shwaitzer on 17/06/2017.
//  Copyright © 2017 Shalom Shwaitzer. All rights reserved.
//

import UIKit
import Material


class FavoritesViewController: UIViewController {
    
    /// Model.
    internal var repoDataSource:RepoDataSource?
    
    /// View.
    internal var tableView: FavoritesTableView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.blueGrey.lighten5
        
        // Feed.
        prepareTableView()
        prepareNavigationItem()
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reloadData()
    }
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        reloadData()
    }
}

/// TableView.
extension FavoritesViewController {
    
    internal func prepareTableView() {
        tableView = FavoritesTableView()
        view.layout(tableView).edges()
    }
    
    internal func  prepareNavigationItem() {
        
        navigationItem.title = "DaGit Trends"
        navigationItem.titleLabel.textColor = .white
        navigationItem.titleLabel.textAlignment = .left
        
        navigationItem.detailLabel.textColor = .white
        navigationItem.detailLabel.textAlignment = .left
    }
    
    internal func reloadData() {
        
        navigationItem.detail = "Favorites \(tableView.data.count)"
    }
}
