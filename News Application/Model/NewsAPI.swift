//
//  NewsAPI.swift
//  News Application
//
//  Created by Onur Alan on 11.05.2024.
//

import Foundation
import Alamofire

class NewsAPI {
    static let sharedInstance = NewsAPI()
    
    func getNews(text:String) {
        
      let url = "https://newsapi.org/v2/everything?q=\(text)&from=2024-04-11&sortBy=publishedAt&apiKey=e0584183ce2841709babaa8b436ad0d8"
        
      AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil)
        .response{ resp in
            switch resp.result{
              case .success(let data):
                do{
                  let jsonData = try JSONDecoder().decode(ResponseOfGetNews.self, from: data!)
                  print(jsonData)
               } catch {
                  print(error.localizedDescription)
               }
             case .failure(let error):
               print(error.localizedDescription)
             }
        }
   }
    
}
struct ResponseOfGetNews: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String
}
struct Source: Codable {
    let id: String?
    let name: String
}
