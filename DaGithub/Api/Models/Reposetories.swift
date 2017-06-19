//
//  Repos.swift
//  DaGithub
//
//  Created by Shalom Shwaitzer on 16/06/2017.
//  Copyright © 2017 Shalom Shwaitzer. All rights reserved.
//

import Foundation
import ObjectMapper

public struct Reposetories:Mappable {
    
   public var totalCount:Int = 0
   public var incompleteResults:Bool = false
   public var items:[Repo] = []
   public var next:String?
    
    init(repos:[Repo]) {
        totalCount = repos.count
        items = repos
    }
    
    public init?(map: Map) {}
    
    mutating public func mapping(map: Map) {
        totalCount        <- map["total_count"]
        incompleteResults <- map["incomplete_results"]
        items             <- map["items"]
    }
}

