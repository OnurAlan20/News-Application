//
//  NewsBrain.swift
//  News Application
//
//  Created by Onur Alan on 11.05.2024.
//

import Foundation
import CoreData
import UIKit


class NewsSwiftCore{
    static let sharedInstance = NewsSwiftCore()
    
    private let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "Articles")
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    func addArticle(article: Article) {
        let managedContext = persistentContainer.viewContext
        
        guard let articleEntity = NSEntityDescription.entity(forEntityName: "ArticleCore", in: managedContext) else {
            print("ArticleCore entity not found.")
            return
        }
        guard let sourceEntity = NSEntityDescription.entity(forEntityName: "SourceCore", in: managedContext) else {
            print("SourceCore entity not found.")
            return
        }
        // NSManagedObject'i ArticleCore entity'sine ait bir nesne olarak tanımla
        guard let newArticle = NSManagedObject(entity: articleEntity, insertInto: managedContext) as? ArticleCore else {
            fatalError("Failed to create ArticleCore object.")
        }
        guard let newSource = NSManagedObject(entity: sourceEntity, insertInto: managedContext) as? SourceCore else {
            fatalError("Failed to create SourceCore object.")
        }
        
        newSource.id = article.source.id
        newSource.name = article.source.name
        
        
        newArticle.source = newSource
        newArticle.author = article.author
        newArticle.title = article.title
        newArticle.descriptionOfArt = article.description
        newArticle.url = article.url
        newArticle.urlToImage = article.urlToImage
        newArticle.publishedAt = article.publishedAt
        newArticle.content = article.content
        
        do {
            try managedContext.save()
            print("Article saved.")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    func getAllArticles() -> [Article]? {
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ArticleCore>(entityName: "ArticleCore")
        
        do {
            let articleCores = try managedContext.fetch(fetchRequest)
            let articles = articleCores.map { articleCore in
                
                let source = Source(id: articleCore.source?.id ?? "", name: articleCore.source?.name ?? "")
                
                return Article(source: source,
                               author: articleCore.author ?? "",
                               title: articleCore.title ?? "",
                               description: articleCore.descriptionOfArt ?? "",
                               url: articleCore.url ?? "",
                               urlToImage: articleCore.urlToImage ?? "",
                               publishedAt: articleCore.publishedAt ?? "",
                               content: articleCore.content ?? "")
            }
            return articles
        } catch let error as NSError {
            print("Error fetching articles: \(error), \(error.userInfo)")
            return nil
        }
    }


    func getArticleWithTitle(_ title: String) -> Article? {
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ArticleCore>(entityName: "ArticleCore")
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            let articles = try managedContext.fetch(fetchRequest)
            if let firstArticle = articles.first {
                let article = Article(
                    source: Source(id: firstArticle.source?.id ?? "", name: firstArticle.source?.name ?? ""),
                    author: firstArticle.author,
                    title: firstArticle.title ?? "",
                    description: firstArticle.descriptionOfArt,
                    url: firstArticle.url ?? "",
                    urlToImage: firstArticle.urlToImage,
                    publishedAt: firstArticle.publishedAt ?? "",
                    content: firstArticle.content ?? ""
                )
                return article
            }
        } catch let error as NSError {
            print("Error fetching article: \(error), \(error.userInfo)")
        }
        
        return nil
    }
    func deleteArticleWithTitle(_ title: String) -> Bool {
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ArticleCore>(entityName: "ArticleCore")
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            let articles = try managedContext.fetch(fetchRequest)
            if let articleToDelete = articles.first {
                managedContext.delete(articleToDelete)
                try managedContext.save()
                return true
            }
        } catch let error as NSError {
            print("Error deleting article: \(error), \(error.userInfo)")
        }
        
        return false
    }
    func deleteAllArticles() -> Bool {
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ArticleCore>(entityName: "ArticleCore")
        
        do {
            let articles = try managedContext.fetch(fetchRequest)
            for article in articles {
                managedContext.delete(article)
            }
            try managedContext.save()
            return true
        } catch let error as NSError {
            print("Error deleting all articles: \(error), \(error.userInfo)")
        }
        
        return false // Makaleler silinemedi
    }
    
    

}
