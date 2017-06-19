//
//  User.swift
//  DaGithub
//
//  Created by Shalom Shwaitzer on 16/06/2017.
//  Copyright © 2017 Shalom Shwaitzer. All rights reserved.
//

import Foundation
import ObjectMapper

public struct User:Mappable {
    
    public var login:String?
    public var id:Int = 0
    public var avatar_url:String?
    public var gravatarId:String?
    public var url:String?
    public var htmlUrl:String?
    public var followersUrl:String?
    public var followingUrl:String?
    public var gistsUrl:String?
    public var starredUrl:String?
    public var subscriptionsUrl:String?
    public var organizationsUrl:String?
    public var reposUrl:String?
    public var eventsUrl:String?
    public var receivedEventsUrl:String?
    public var type:String?
    public var siteAdmin:Bool = false
    
    public init?(map: Map) {}
    
    mutating public func mapping(map: Map) {
        
        login              <- map["login"]
        id                 <- map["id"]
        avatar_url         <- map["avatar_url"]
        gravatarId         <- map["gravatar_id"]
        url                <- map["url"]
        htmlUrl            <- map["html_url"]
        followersUrl       <- map["followers_url"]
        followingUrl       <- map["following_url"]
        gistsUrl           <- map["gists_url"]
        starredUrl         <- map["starred_url"]
        subscriptionsUrl   <- map["subscriptions_url"]
        organizationsUrl   <- map["organizations_url"]
        reposUrl           <- map["repos_url"]
        eventsUrl          <- map["events_url"]
        receivedEventsUrl  <- map["received_events_url"]
        type               <- map["type"]
        siteAdmin          <- map["site_admin"]
    }
}
