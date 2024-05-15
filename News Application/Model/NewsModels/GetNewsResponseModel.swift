//
//  NewsResponseModel.swift
//  News Application
//
//  Created by Onur Alan on 11.05.2024.
//

import Foundation

struct ResponseModelOfGetNews: Codable {
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
