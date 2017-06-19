//
//  GitCMS.swift
//  DaGithub
//
//  Created by Shalom Shwaitzer on 17/06/2017.
//  Copyright © 2017 Shalom Shwaitzer. All rights reserved.
//

import Foundation
import Alamofire
import FutureKit

/// Git Communication Service Interface
open class GitCSI {
    
    open class func getTrendings(since:GitApi.TimeSpan, withQuery q:String? = nil)->Future<Reposetories> {
        
    let reposPromiss = Promise<Reposetories>()
    
        GitApi.trending(since,q).execute { (response:DataResponse<Reposetories>) in
            
            if var result = response.result.value {
                result.next = response.getHeaderLink().next
                reposPromiss.completeWithSuccess(result)
            }else{
                reposPromiss.completeWithFail(response.result.error!)
            }
        }
    
    
        return reposPromiss.future
    }
    
    open class func getReposetories(withPath path:String)->Future<Reposetories> {
        
        let reposPromiss = Promise<Reposetories>()
        
        GitApi.reposetories(path).execute { (response:DataResponse<Reposetories>) in
            if var result = response.result.value {
                result.next = response.getHeaderLink().next
                reposPromiss.completeWithSuccess(result)
            }else{
                reposPromiss.completeWithFail(response.result.error!)
            }
        }
        
        return reposPromiss.future
    }
}

private extension DataResponse {
   
    func getHeaderLink() -> (next:String?, last:String?) {
        
        if let link = response?.allHeaderFields ["Link"] as? String  {
            
            let links = self.extractURLs(source: link)
            let next = links.first
            var last = links.last
            
            if next == last {
                last = nil
            }
            
            return (next, last)
        }
        
        return (nil,nil)
    }
    
    private func extractURLs(source:String)->[String] {
        
        let types: NSTextCheckingResult.CheckingType = .link
        let detector = try? NSDataDetector(types: types.rawValue)
        
        guard let detect = detector else {
            return []
        }
        
        let matches = detect.matches(in: source, options: .reportCompletion, range: NSMakeRange(0, source.characters.count))
        
        var urls:[String] = []
        
        for match in matches {
            urls.append(match.url!.absoluteString)
        }
        
        return urls
    }
    
    
}
