//
//  Github.swift
//  DaGithub
//
//  Created by Shalom Shwaitzer on 16/06/2017.
//  Copyright © 2017 Shalom Shwaitzer. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import Foundation

/**
 Github Api Interface
 
 - trending: TimeSpan base request (daily, weekly, monthly)
 */
public enum GitApi {
    case trending(TimeSpan,String?)
    case reposetories(String)
}

extension GitApi:URLRequestConvertible {
    
    
    private var result:(method:Alamofire.HTTPMethod, path:String, params:Parameters) {
        switch self {
            case .trending(let since, let qualifiers):
                
                var q = ""
                if qualifiers != nil {
                    q = "\(qualifiers!)+"
                }
                
                let params = ["q"     :"\(q)created:>\(since.value)",
                              "sort"  :"stars",
                              "order" :"desc"]
                
                return (.get, "/search/repositories", params)
            
            case .reposetories(let path):
                return (.get, path, [:])
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        
        let baseURL = "https://api.github.com"
        var url:URL!
        
        switch self {
            case .trending:
                url        = Foundation.URL(string: baseURL)!.appendingPathComponent(result.path)
            case .reposetories:
                url        = Foundation.URL(string: result.path)!
        }
       
        var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = result.method.rawValue
        
        let encoding = try URLEncoding.methodDependent.encode(urlRequest, with: result.params)
        return encoding
    }
    
    public func execute<T:BaseMappable>(handler:@escaping (DataResponse<T>)-> Void) {
        DispatchQueue.global(qos: .background).async {
            Alamofire.SessionManager.default.request(self).responseObject(completionHandler: handler)
        }
    }
}


// MARK: - TimeSpan Parser
extension GitApi {
    
    public enum TimeSpan:String {
        
        case daily,weekly,monthly
        
        var value:String {
            
            let calendar = Calendar.current
            var date:Date = Date()
            
            switch self {
                case .daily:   date = calendar.date(byAdding: .day, value: -1, to: Date())!
                case .weekly:  date = calendar.date(byAdding: .day, value: -7, to: Date())!
                case .monthly: date = calendar.date(byAdding: .month, value: -1, to: Date())!
            }
            
            let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from:date)
        }
    }
}
