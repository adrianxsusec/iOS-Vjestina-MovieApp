import Foundation
import CoreData

class MoviesRepository {
    var movieDatabaseDataSource: MovieDatabaseDataSource = MovieDatabaseDataSource()
    var movieNetworkDataSource: MovieNetworkDataSource = MovieNetworkDataSource()
    let categories: [MovieCategory] = [.topRated, .trending, .recommended, .popular]
    
    func saveDownloadedMovies() {
        
        for category in categories {
            let moviesForSave = movieNetworkDataSource.getMoviesByCategory(category: category)
            //movieDatabaseDataSource.saveMovies(moviesForSave: movieNetworkDataSource.getMoviesByCategory(category: category))
            DispatchQueue.main.async {
                self.movieDatabaseDataSource.saveMovies(moviesForSave: moviesForSave)
                print("Movies saved")
                print(self.modelToMovie(models: self.movieDatabaseDataSource.fetchMovies()))
            }
        }
//        print("Movies saved")
//        print(modelToMovie(models: movieDatabaseDataSource.fetchMovies()))
    }
    
    func getMoviesByCategory(category: MovieCategory) -> [Movie]{
        return movieNetworkDataSource.getMoviesByCategory(category: category)
    }
    
    func getMoviesByName(name: String) -> [MovieViewModel]?{
        return modelToMovie(models: movieDatabaseDataSource.fetchMoviesByName(name: name)!)
    }
    
    func modelToMovie(models: [MovieModel]) -> [MovieViewModel]{
        
        var movies: [MovieViewModel] = []
        
        for model in models {
            let movie = MovieViewModel(model: model)
            movies.append(movie)
        }
        
        return movies
    }
    
    func getFavoriteMovies() -> [MovieViewModel] {
        return modelToMovie(models: movieDatabaseDataSource.fetchFavoriteMovies())
    }
    
}
