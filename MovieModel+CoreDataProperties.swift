//
//  MovieModel+CoreDataProperties.swift
//  MovieApp
//
//  Created by Adrian Sušec on 28.05.2022..
//
//

import Foundation
import CoreData


extension MovieModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieModel> {
        return NSFetchRequest<MovieModel>(entityName: "MovieModel")
    }

    @NSManaged public var adult: Bool
    @NSManaged public var backdrop_path: String?
    @NSManaged public var favorite: Bool
    @NSManaged public var genre_ids: [Int64]?
    @NSManaged public var id: Int64
    @NSManaged public var original_language: String?
    @NSManaged public var original_title: String?
    @NSManaged public var overview: String?
    @NSManaged public var popularity: Double
    @NSManaged public var poster_path: String?
    @NSManaged public var release_date: String?
    @NSManaged public var title: String?
    @NSManaged public var video: Bool
    @NSManaged public var vote_average: Double
    @NSManaged public var vote_count: Int64
    @NSManaged public var genres: NSSet?
    @NSManaged public var groups: NSSet?

}

// MARK: Generated accessors for genres
extension MovieModel {

    @objc(addGenresObject:)
    @NSManaged public func addToGenres(_ value: GenreModel)

    @objc(removeGenresObject:)
    @NSManaged public func removeFromGenres(_ value: GenreModel)

    @objc(addGenres:)
    @NSManaged public func addToGenres(_ values: NSSet)

    @objc(removeGenres:)
    @NSManaged public func removeFromGenres(_ values: NSSet)

}

// MARK: Generated accessors for groups
extension MovieModel {

    @objc(addGroupsObject:)
    @NSManaged public func addToGroups(_ value: GroupModel)

    @objc(removeGroupsObject:)
    @NSManaged public func removeFromGroups(_ value: GroupModel)

    @objc(addGroups:)
    @NSManaged public func addToGroups(_ values: NSSet)

    @objc(removeGroups:)
    @NSManaged public func removeFromGroups(_ values: NSSet)

}

extension MovieModel : Identifiable {

}
