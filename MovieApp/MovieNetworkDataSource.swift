import Foundation
import CoreData

class MovieNetworkDataSource {
    let networkService = NetworkService()

    func getMoviesByCategory(category: MovieCategory) -> [Movie] {
        var movies: [Movie] = []
        
        switch category {
        case .popular:
            networkService.get(url: url_popular) { (result: Result<MoviesInGroup, RequestError>) in
                
                switch result {
                case .success(_):
                    do {
                        movies = try result.get().results
                        print("popular movies in MovieNetworkDataSource")
                    } catch {
                        print("Failed to get popular movies in MovieNetworkDataSource")
                    }
                case .failure(_):
                    print("popular error")
                    return
                }
            }
        case .recommended:
            networkService.getRecommended(url: url_recommended) { (result: Result<MoviesInGroup, RequestError>) in
                
                switch result {
                case .success(_):
                    do {
                        movies = try result.get().results
                        print("recommended movies in MovieNetworkDataSource")
                    } catch {
                        print("Failed to get recommended movies in MovieNetworkDataSource")
                    }
                case .failure(_):
                    print("recommended error")
                    return
                }
            }
        case .trending:
            networkService.getTrending(url: url_trending) { (result: Result<MoviesInGroup, RequestError>) in
                
                switch result {
                case .success(_):
                    do {
                        movies = try result.get().results
                        print("trending movies in MovieNetworkDataSource")
                    } catch {
                        print("Failed to get trending movies in MovieNetworkDataSource")
                    }
                case .failure(_):
                    print("trending error")
                    return
                }
            }
        case .topRated:
            networkService.getRecommended(url: url_topRated) { (result: Result<MoviesInGroup, RequestError>) in
                
                switch result {
                case .success(_):
                    do {
                        movies = try result.get().results
                        print("top rated movies in MovieNetworkDataSource")
                    } catch {
                        print("Failed to get top rated movies in MovieNetworkDataSource")
                    }
                case .failure(_):
                    print("top rated error")
                    return
                }
            }
        }
        
        return movies
    }
    
    func getGenres() -> [Genre] {
        
        var genres: [Genre] = []
        
        let networkService = NetworkService()
        
        guard let url = URL(string: url_genres) else { return [] }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print(request)
        
        networkService.executeUrlRequest(request) { (result: Result<Genres, RequestError>) in
            switch result {
            case .success(_):
                do {
                    genres = try result.get().genres
                    print("Genres fetched")
                } catch {
                    print("Genre fetching error")
                }
            
            case .failure(let error):
                print(error)
                return
            }
        }
        
        return genres
    }
}
