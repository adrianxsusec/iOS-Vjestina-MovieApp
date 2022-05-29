import Foundation
import CoreData

struct MovieViewModel {
    let adult: Bool
    let backdrop_path: String?
    let genre_ids: [Int64]?
    let id: Int64
    let original_language: String?
    let original_title: String?
    let overview: String?
    let popularity: Double
    let poster_path: String?
    let release_date: String?
    let title: String?
    let video: Bool
    let vote_average: Double
    let vote_count: Int64
    let favorite: Bool
    let genres: NSSet?
    let groups: NSSet?
    
    init(model: MovieModel) {
        self.adult = model.adult
        self.backdrop_path = model.backdrop_path
        self.genre_ids = model.genre_ids
        self.id = model.id
        self.original_language = model.original_language
        self.original_title = model.original_title
        self.overview = model.overview
        self.popularity = model.popularity
        self.poster_path = model.poster_path
        self.release_date = model.release_date
        self.title = model.title
        self.video = model.video
        self.vote_average = model.vote_average
        self.vote_count = model.vote_count
        self.favorite = model.favorite
        self.genres = []
        self.groups = []
    }
}
