//  ReposViewController.swift
//  DaGithub
//
//  Created by Shalom Shwaitzer on 17/06/2017.
//  Copyright © 2017 Shalom Shwaitzer. All rights reserved.
//

import UIKit
import Material


class RepoViewController: UIViewController {
    internal var category: String
    
    /// Model.
    internal var repoDataSource:RepoDataSource?
    
    /// View.
    internal var tableView: RepoTableView!
    
    required init?(coder aDecoder: NSCoder) {
        category = ""
        super.init(coder: aDecoder)
        preparePageTabBarItem()
    }
    
    init(dataSource:RepoDataSource) {
        self.category = dataSource.title.capitalized
        
        super.init(nibName: nil, bundle: nil)
        self.repoDataSource = dataSource
        
        preparePageTabBarItem()
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.blueGrey.lighten5
        
        // Model.
        prepareGraph()
        prepareSearch()
        
        // Feed.
        prepareTableView()
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

/// Model.
extension RepoViewController {
    internal func prepareGraph() {
        
    }
    
    internal func prepareSearch() {
       
    }
}

/// PageTabBar.
extension RepoViewController {
    internal func preparePageTabBarItem() {
        pageTabBarItem.title = category
        pageTabBarItem.titleColor = .white
    }
}

/// TableView.
extension RepoViewController {
    internal func prepareTableView() {
        tableView = RepoTableView(dataSource: self.repoDataSource!)
        tableView.onTableUpdate = { [weak self] in
            self?.reloadData()
        }
        view.layout(tableView).edges()
    }
    
    internal func reloadData() {
        
        MainController.instance?.navigationItem.detail = "\(category) \(tableView.data.count)"
    }
}
