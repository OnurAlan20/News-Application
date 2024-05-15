//
//  NewsAPI.swift
//  News Application
//
//  Created by Onur Alan on 11.05.2024.
//

import Foundation
import Alamofire
import UIKit

class NewsAPI {
    static let sharedInstance = NewsAPI()
    
    var articles: [Article] = [] 

    
    func getNews(text: String, completion: @escaping (ResponseModelOfGetNews?, Error?) -> Void) {
        let url = "https://newsapi.org/v2/everything?q=\(text)&page=1&apiKey=e0584183ce2841709babaa8b436ad0d8"
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil)
            .response { resp in
                switch resp.result {
                case .success(let data):
                    do {
                        let jsonData = try JSONDecoder().decode(ResponseModelOfGetNews.self, from: data!)
                        completion(jsonData, nil)
                    } catch {
                        completion(nil, error)
                    }
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }
    
}
