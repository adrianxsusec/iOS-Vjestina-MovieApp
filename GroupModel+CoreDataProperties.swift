import Foundation
import CoreData


extension GroupModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroupModel> {
        return NSFetchRequest<GroupModel>(entityName: "GroupModel")
    }

    @NSManaged public var group: String?
    @NSManaged public var movies: NSSet?

}

// MARK: Generated accessors for movies
extension GroupModel {

    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: MovieModel)

    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: MovieModel)

    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: NSSet)

    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: NSSet)

}

extension GroupModel : Identifiable {

}
