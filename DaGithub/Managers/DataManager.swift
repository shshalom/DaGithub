//
//  DataManager.swift
//  DaGithub
//
//  Created by Shalom Shwaitzer on 18/06/2017.
//  Copyright © 2017 Shalom Shwaitzer. All rights reserved.
//

import Foundation

/**
 *  Manage persisted and in-memory data
 */
struct DataManager {
    
    private static var _favorites:[Int:Repo] = [:]
    public static var favorites:[Int:Repo] {
        
        set {
            _favorites = newValue
            saveFavorites()
        }
        
        get {
            if _favorites.isEmpty {
              _favorites = loadFavorites()
            }
            
            return _favorites
        }
    }
    
    
    internal static func saveFavorites() {
        let repoSource:[Repo] = _favorites.map{ $1 }
        
        if !repoSource.isEmpty {
            
            if let repos = Reposetories(repos: repoSource).toJSONString() {
                UserDefaults.standard.set(repos, forKey: "daGithub.favorites")
                UserDefaults.standard.synchronize()
            }
        }
    }
    
    internal static func loadFavorites()->[Int:Repo] {
        
        if let result = UserDefaults.standard.string(forKey: "daGithub.favorites") {
            let respos = Reposetories(JSONString: result)
            if let repoDict:[Int:Repo] = (respos?.items.reduce([Int:Repo]()) { dict, rep in
                var ret = dict
                ret[rep.id] = rep
                return ret
                }) {
                
                return repoDict
            }
        }
        return [:]
    }
    
}
