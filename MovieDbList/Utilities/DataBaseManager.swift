//
//  DataBaseManager.swift
//  MovieDbList
//
//  Created by webwerks on 04/11/20.
//

import UIKit
import CoreData
class DataBaseManager: NSObject {
    // MARK: - Core Data get movie list
    func getRecentMovie()->[MovieModel]
    {
        var movies:[MovieModel] = []
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        request.returnsObjectsAsFaults = false
        let context = Constant.appDelegate.persistentContainer.viewContext
        do {
            let result = try context.fetch(request)
            for movie in result as! [Movie] {
                let localMovie = MovieModel(from: movie)
                movies.append(localMovie)
            }
        } catch {
            print(error.localizedDescription)
        }
        return movies
    }
    
    // MARK: - Core Data save movie
    func saveNewsMovie(movie:MovieModel)
    {
        if isMoviePresent(movie: movie){
            //Deletet movieavo to avoid duplicaterecords
            self.deletetMovie(movie: movie)
        }
        if isRecentlMaximumExceed(){
            self.deletetLastMovie()
        }
        let managedContext = Constant.appDelegate.persistentContainer.viewContext
        let newsEntity = NSEntityDescription.entity(forEntityName: "Movie", in: managedContext)!
        let newsArticle:Movie = NSManagedObject(entity: newsEntity, insertInto: managedContext) as! Movie
        newsArticle.setValue(movie.backdropPath , forKey: "backdropPath")
        newsArticle.setValue(movie.id , forKey: "id")
        newsArticle.setValue(movie.originalTitle , forKey: "originalTitle")
        newsArticle.setValue(movie.overview , forKey: "overview")
        newsArticle.setValue(movie.posterPath , forKey: "posterPath")
        newsArticle.setValue(movie.releaseDate , forKey: "releaseDate")
        newsArticle.setValue(movie.title , forKey: "title")
        newsArticle.setValue(movie.voteAverage , forKey: "voteAverage")
        newsArticle.setValue(movie.voteCount , forKey: "voteCount")
        do {
            try managedContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    // MARK: - Core Data delete movie if present
    func deletetMovie(movie:MovieModel)
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        request.predicate = NSPredicate(format: "id == %i", movie.id ?? 0)
        request.returnsObjectsAsFaults = false
        let context = Constant.appDelegate.persistentContainer.viewContext
        do {
            let result = try context.fetch(request)
            for data in result as! [Movie] {
                context.delete(data)
            }
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    // MARK: - Core Data delete movie if more than RECENT_MAXIMUM (Cache can have a maximum of 5 results)
    func deletetLastMovie()
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        request.returnsObjectsAsFaults = false
        let context = Constant.appDelegate.persistentContainer.viewContext
        do {
            let result = try context.fetch(request)
            if result.count > Constant.RECENT_MAXIMUM-1{
                for data in result as! [Movie] {
                    context.delete(data)
                    break
                }
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
extension DataBaseManager{
    // Check is movie present
    func isMoviePresent(movie:MovieModel) -> Bool {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        request.predicate = NSPredicate(format: "id == %i", movie.id ?? 0)
        request.returnsObjectsAsFaults = false
        let context = Constant.appDelegate.persistentContainer.viewContext
        do {
            let result = try context.fetch(request)
            return (result.count > 0)
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
    // Check is movie present
    func isRecentlMaximumExceed() -> Bool {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        request.returnsObjectsAsFaults = false
        let context = Constant.appDelegate.persistentContainer.viewContext
        do {
            let result = try context.fetch(request)
            if result.count > Constant.RECENT_MAXIMUM-1{
                return true
            }
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
}
