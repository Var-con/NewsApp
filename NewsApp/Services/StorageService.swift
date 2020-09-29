//
//  StorageService.swift
//  TestNewsApp
//
//  Created by Станислав Климов on 28.09.2020.
//

import Foundation
import CoreData

class StorageManager {
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TestNewsApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func addNewsToStorage(with news: [MainNews]) {
        guard let data = try? JSONEncoder().encode(news) else { return }
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "News", in: context) else { return }
        guard let news = NSManagedObject(entity: entityDescription, insertInto: context) as? News else { return }
        news.newsData = data
        do {
            try context.save()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    func getNewsFromStorage(completionHandler: @escaping ([MainNews]) -> Void) {
        var news: [News] = []
        var allNews: [MainNews] = []
        let fetchRequest: NSFetchRequest<News> = News.fetchRequest()
        do {
            news = try context.fetch(fetchRequest)
        }
        catch let error {
            print(error.localizedDescription)
        }
        for info in news {
            guard let dataFromStorageList = info.newsData else { return }
            guard let arrayOfStorageNews = try? JSONDecoder().decode([MainNews].self, from: dataFromStorageList) else { return }
            allNews.append(contentsOf: arrayOfStorageNews)
            completionHandler(allNews)
        }
    }
    
    func clearStorage() {
        let entity = "News"
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                context.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
}
