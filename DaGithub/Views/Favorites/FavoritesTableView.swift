//
//  TableView.swift
//  DaGithub
//
//  Created by Shalom Shwaitzer on 17/06/2017.
//  Copyright © 2017 Shalom Shwaitzer. All rights reserved.
//

import UIKit
import Material

class FavoritesTableView: UITableView {
    internal lazy var heights = [IndexPath: CGFloat]()
    
    public var data:[Repo] {
        
        let list:[Repo] = DataManager.favorites.map { return $1 }
        
        return list.sorted { (a, b) -> Bool in
            return a.stargazersCount > b.stargazersCount
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepare()
    }
    
    public init() {
        super.init(frame: .zero, style: .plain)
        prepare()
    }
    
    /// Prepares the tableView.
    open func prepare() {
        delegate = self
        dataSource = self
        separatorStyle = .none
        backgroundColor = nil
        
        register(FavoritesTableViewCell.self, forCellReuseIdentifier: "FavoritesTableViewCell")
    }
}

extension FavoritesTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /// Prepares the cells within the tableView.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell", for: indexPath) as! FavoritesTableViewCell
        cell.data = data[indexPath.row]
        cell.isLast = indexPath.row == data.count - 1
        heights[indexPath] = cell.height
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let repo = data[indexPath.row]
        let repoDetailesController = RepoDetailesController(repo: repo)
        
        MainController.instance?.navigation?.showDetailViewController(repoDetailesController, sender: self)
    }

}

extension FavoritesTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heights[indexPath] ?? height
    }
}
