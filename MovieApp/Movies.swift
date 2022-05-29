import Foundation

struct MoviesInGroup: Codable {
    let page: Int
    let results: [Movie]
    let total_pages: Int
    let total_results: Int
}

struct Movie: Codable {
    let adult: Bool
    let backdrop_path: String
    let genre_ids: [Int]
    let id: Int
    let original_language: String
    let original_title: String
    let overview: String
    let popularity: Double
    let poster_path: String
    let release_date: String
    let title: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
}

struct Genre: Codable {
    let id: Int
    let name: String
}

struct Genres: Codable {
    let genres: [Genre]
}

struct MovieAccurate: Codable {
    let adult: Bool?
    let backdrop_path: String?
    let belongs_to_collection: BelongsToCollection?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let id: Int?
    let imdb_id: String?
    let original_language: String?
    let original_title: String?
    let overview: String?
    let popularity: Double?
    let poster_path: String?
    let production_companies: [ProductionCompany]?
    let production_countries: [ProductionCountry]?
    let release_date: String?
    let revenue: Int?
    let runtime: Int?
    let spoken_languages: [SpokenLanguage]?
    let status: String?
    let tagline: String?
    let title: String?
    let video: Bool?
    let vote_average: Double?
    let vote_count: Int?
}

struct BelongsToCollection: Codable {
    let id: Int?
    let name: String?
    let poster_path: String?
    let backdrop_path: String?
}

struct SpokenLanguage: Codable {
    let english_name: String?
    let iso_639_1: String?
    let name: String?
}

struct ProductionCountry: Codable {
    let iso_3166_1: String?
    let name: String?
}

struct ProductionCompany: Codable {
    let id: Int?
    let logo_path: String?
    let name: String?
    let origin_country: String?
}

enum MovieCategory {
    case popular
    case trending
    case topRated
    case recommended
    
    var description: String {
        switch self {
        case .popular: return "Popular movies"
        case .trending: return "Trending movies"
        case .topRated: return "Top ratings"
        case .recommended: return "Recommended for you"
        }
    }
}
