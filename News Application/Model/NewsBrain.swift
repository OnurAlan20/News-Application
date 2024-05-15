//
//  NewsBrain.swift
//  News Application
//
//  Created by Onur Alan on 11.05.2024.
//

import Foundation
import CoreData


class NewsBrain{
    static let sharedInstance = NewsBrain()
    
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
        // Özellikleri doğru şekilde ayarla
        
        
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
                
                var source = Source(id: articleCore.source?.id ?? "", name: articleCore.source?.name ?? "")
                
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


    func getArticleWithTitle(_ title: String) -> ArticleCore? {
        let managedContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ArticleCore>(entityName: "ArticleCore")
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            let articles = try managedContext.fetch(fetchRequest)
            return articles.first
        } catch let error as NSError {
            print("Error fetching article: \(error), \(error.userInfo)")
            return nil
        }
    }
    
    
}
