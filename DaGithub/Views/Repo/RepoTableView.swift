//
//  TableView.swift
//  DaGithub
//
//  Created by Shalom Shwaitzer on 17/06/2017.
//  Copyright © 2017 Shalom Shwaitzer. All rights reserved.
//

import UIKit
import Material

class RepoTableView: UITableView {
    internal lazy var heights = [IndexPath: CGFloat]()
    fileprivate var isNewDataLoading:Bool = false
    fileprivate var repoDataSource:RepoDataSource?
    
    public var onTableUpdate:os_block_t?
    
    public var data:[Repo] {
        
        let list = repoDataSource?.data ?? []
        
        return list.sorted { (a, b) -> Bool in
            return a.stargazersCount > b.stargazersCount
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepare()
    }
    
    public init(dataSource:RepoDataSource) {
        super.init(frame: .zero, style: .plain)
        
        self.repoDataSource = dataSource
        repoDataSource?.sourceUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.isNewDataLoading = false
                self?.reloadData()
                self?.onTableUpdate?()
            }
        }
        
        prepare()
    }
    
    /// Prepares the tableView.
    open func prepare() {
        delegate = self
        dataSource = self
        separatorStyle = .none
        backgroundColor = nil
        
        register(RepoTableViewCell.self, forCellReuseIdentifier: "RepoTableViewCell")
    }
    
    func setEmptyStateIfNeeded() {
        
        if data.isEmpty {
            let icon = UIImage.icon(from: .Octicon, iconColor: Color.blue.lighten1, code: "octoface", imageSize: CGSize(width:70,height:70), ofSize: 70)
            
            let imageView = UIImageView(image:icon)
                imageView.contentMode = .center
            
            self.backgroundView = imageView
        }else{
            self.backgroundView = nil
        }
    }
}

extension RepoTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        setEmptyStateIfNeeded()
        return data.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /// Prepares the cells within the tableView.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoTableViewCell", for: indexPath) as! RepoTableViewCell
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if ((scrollView.contentOffset.y + scrollView.frame.size.height) + 100 >= scrollView.contentSize.height)
        {
            if !isNewDataLoading{

                isNewDataLoading = true
                repoDataSource?.loadNext()
            }
        }
    }
}

extension RepoTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heights[indexPath] ?? height
    }
}
