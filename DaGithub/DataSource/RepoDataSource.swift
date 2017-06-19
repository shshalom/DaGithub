//
//  RepoDataSource.swift
//  DaGithub
//
//  Created by Shalom Shwaitzer on 17/06/2017.
//  Copyright © 2017 Shalom Shwaitzer. All rights reserved.
//

import Foundation

class  RepoDataSource {
    
    public var sourceUpdated:os_block_t?
    
    private var _source:Reposetories? {
        didSet {
            sourceUpdated?()
        }
    }
    
    public var title: String  = ""
    
    var data: [Repo] {
        return _source?.items ?? []
    }
    
    var hasMore: Bool {
        return _source?.next != nil
    }
    
    init(timespan:GitApi.TimeSpan, title:String) {
        
        self.title = title
        
        let trends = GitCSI.getTrendings(since: timespan)
        
        trends.onComplete(.main) { [weak self] result in
            if let repo = result.value {
                self?._source = repo
            }
        }
    }
    
    public func loadNext() {
        
        if let nextPagePath = _source?.next {
            let nextTrendes = GitCSI.getReposetories(withPath: nextPagePath)
            nextTrendes.onComplete(.main) { [weak self] result in
                if let repo = result.value {
                    
                    var source = self?._source
                    
                    source?.items.append(contentsOf: repo.items)
                    source?.totalCount += repo.totalCount
                    source?.incompleteResults = repo.incompleteResults
                    source?.next = repo.next
                    
                    self?._source = source
                }
            }
        }
    }
    
}
