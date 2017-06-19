//
//  Repo.swift
//  DaGithub
//
//  Created by Shalom Shwaitzer on 16/06/2017.
//  Copyright © 2017 Shalom Shwaitzer. All rights reserved.
//

import Foundation
import ObjectMapper

public struct Repo:Mappable {
    
    public var id:Int = 0
    public var name:String?
    public var fullName:String?
    public var owner:User?
    
    public var `private`:Bool = false
    public var htmlUrl:String?
    public var description:String?
    public var fork:Bool = false
    public var url:String?
    public var forksUrl:String?
    public var keysUrl:String?
    public var collaboratorsUrl:String?
    public var teamsUrl:String?
    public var hooksUrl:String?
    public var issueEventsUrl:String?
    public var eventsUrl:String?
    public var assigneesUrl:String?
    public var branchesUrl:String?
    public var tagsUrl:String?
    public var blobsUrl:String?
    public var gitTagsUrl:String?
    public var gitRefsUrl:String?
    public var treesUrl:String?
    public var statusesUrl:String?
    public var languagesUrl:String?
    public var stargazersUrl:String?
    public var contributorsUrl:String?
    public var subscribersUrl:String?
    public var subscriptionUrl:String?
    public var commitsUrl:String?
    public var gitCommitsUrl:String?
    public var commentsUrl:String?
    public var issueCommentUrl:String?
    public var contentsUrl:String?
    public var compareUrl:String?
    public var mergesUrl:String?
    public var archiveUrl:String?
    public var downloadsUrl:String?
    public var issuesUrl:String?
    public var pullsUrl:String?
    public var milestonesUrl:String?
    public var notificationsUrl:String?
    public var labelsUrl:String?
    public var releasesUrl:String?
    public var deploymentsUrl:String?
    public var createdAt:String?
    public var updatedAt:String?
    public var pushedAt:String?
    public var gitUrl:String?
    public var sshUrl:String?
    public var cloneUrl:String?
    public var svnUrl:String?
    public var homepage:String?
    public var size:Int = 0
    public var stargazersCount:Int = 0
    public var watchersCount:Int = 0
    public var language:String?
    public var hasIssues:Bool = false
    public var hasProjects:Bool = false
    public var hasDownloads:Bool = false
    public var hasWiki:Bool = false
    public var hasPages:Bool = false
    public var forksCount:Int = 0
    public var mirrorUrl:String?
    public var openIssuesCount:Int = 0
    public var forks:Int = 0
    public var openIssues:String?
    public var watchers:String?
    public var defaultBranch:String?
    public var score:Int = 0
    
    public init?(map: Map) {}
    
    mutating public func mapping(map: Map) {
        
        id               <- map["id"]
        name             <- map["name"]
        fullName         <- map["full_name"]
        owner            <- map["owner"]
        `private`        <- map["private"]
        htmlUrl          <- map["html_url"]
        description      <- map["description"]
        fork             <- map["fork"]
        url              <- map["url"]
        forksUrl         <- map["forks_url"]
        keysUrl          <- map["keys_url"]
        collaboratorsUrl <- map["collaborators_url"]
        teamsUrl         <- map["teams_url"]
        hooksUrl         <- map["hooks_url"]
        issueEventsUrl   <- map["issue_events_url"]
        eventsUrl        <- map["events_url"]
        assigneesUrl     <- map["assignees_url"]
        branchesUrl      <- map["branches_url"]
        tagsUrl          <- map["tags_url"]
        blobsUrl         <- map["blobs_url"]
        gitTagsUrl       <- map["git_tags_url"]
        gitRefsUrl       <- map["git_refs_url"]
        treesUrl         <- map["trees_url"]
        statusesUrl      <- map["statuses_url"]
        languagesUrl     <- map["languages_url"]
        stargazersUrl    <- map["stargazers_url"]
        contributorsUrl  <- map["contributors_url"]
        subscribersUrl   <- map["subscribers_url"]
        subscriptionUrl  <- map["subscription_url"]
        commitsUrl       <- map["commits_url"]
        gitCommitsUrl    <- map["git_commits_url"]
        commentsUrl      <- map["comments_url"]
        issueCommentUrl  <- map["issue_comment_url"]
        contentsUrl      <- map["contents_url"]
        compareUrl       <- map["compare_url"]
        mergesUrl        <- map["merges_url"]
        archiveUrl       <- map["archive_url"]
        downloadsUrl     <- map["downloads_url"]
        issuesUrl        <- map["issues_url"]
        pullsUrl         <- map["pulls_url"]
        milestonesUrl    <- map["milestones_url"]
        notificationsUrl <- map["notifications_url"]
        labelsUrl        <- map["labels_url"]
        releasesUrl      <- map["releases_url"]
        deploymentsUrl   <- map["deployments_url"]
        createdAt        <- map["created_at"]
        updatedAt        <- map["updated_at"]
        pushedAt         <- map["pushed_at"]
        gitUrl           <- map["git_url"]
        sshUrl           <- map["ssh_url"]
        cloneUrl         <- map["clone_url"]
        svnUrl           <- map["svn_url"]
        homepage         <- map["homepage"]
        size             <- map["size"]
        stargazersCount  <- map["stargazers_count"]
        watchersCount    <- map["watchers_count"]
        language         <- map["language"]
        hasIssues        <- map["has_issues"]
        hasProjects      <- map["has_projects"]
        hasDownloads     <- map["has_downloads"]
        hasWiki          <- map["has_wiki"]
        hasPages         <- map["has_pages"]
        forksCount       <- map["forks_count"]
        mirrorUrl        <- map["mirror_url"]
        openIssuesCount  <- map["open_issues_count"]
        forks            <- map["forks"]
        openIssues       <- map["open_issues"]
        watchers         <- map["watchers"]
        defaultBranch    <- map["default_branch"]
        score            <- map["score"]
    }
}

//Transients
extension Repo {
    
    var createdDate:Date? {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "us")
        dateFormatter.formatterBehavior = .default
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        if let date = self.createdAt {
            return dateFormatter.date(from:date)!
        }
        
        return nil
    }
}
