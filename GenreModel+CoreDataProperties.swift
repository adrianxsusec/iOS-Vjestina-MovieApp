//
//  GenreModel+CoreDataProperties.swift
//  MovieApp
//
//  Created by Adrian Sušec on 25.05.2022..
//
//

import Foundation
import CoreData


extension GenreModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GenreModel> {
        return NSFetchRequest<GenreModel>(entityName: "GenreModel")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var movies: NSSet?

}

// MARK: Generated accessors for movies
extension GenreModel {

    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: MovieModel)

    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: MovieModel)

    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: NSSet)

    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: NSSet)

}

extension GenreModel : Identifiable {

}
