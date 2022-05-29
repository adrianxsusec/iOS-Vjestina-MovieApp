import Foundation
import CoreData

class MovieDatabaseDataSource {
    
    func fetchMovies() -> [MovieModel] {
        let coreDataStack = CoreDataStack()
        let managedContext = coreDataStack.persistentContainer.viewContext
        
        let request: NSFetchRequest<MovieModel> = MovieModel.fetchRequest()
        do {
            let results = try managedContext.fetch(request)
            return results
        } catch let error as NSError {
            print("Error \(error) when fetching movies");
            return []
        }
    }
    
    func fetchMovieById(id: Int) -> MovieModel? {
        let coreDataStack = CoreDataStack()
        let managedContext = coreDataStack.persistentContainer.viewContext
        
        let request: NSFetchRequest<MovieModel> = MovieModel.fetchRequest()
        let predicate = NSPredicate(format: "id = %@", "\(id)")
        request.predicate = predicate
        request.fetchLimit = 1
        
        do {
            let results = try managedContext.fetch(request).first
            return results
        } catch let error as NSError {
            print("Error \(error) when fetching a movie with id \(id)")
            return nil
        }
    }
    
    func fetchMoviesByName(name: String) -> [MovieModel]? {
        let coreDataStack = CoreDataStack()
        let managedContext = coreDataStack.persistentContainer.viewContext
        
        let request: NSFetchRequest<MovieModel> = MovieModel.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS %@", "\(name)")
        request.predicate = predicate
        
        do {
            let results = try managedContext.fetch(request)
            return results
        } catch let error as NSError {
            print("Error \(error) when fetching movie with title containing \(name)")
            return []
        }
    }
    
    func setFavorite(id: Int) {
        let coreDataStack = CoreDataStack()
        let managedContext = coreDataStack.persistentContainer.viewContext
        
        let movieFavorite = fetchMovieById(id: id)
        
        if (movieFavorite?.favorite == true) {
            movieFavorite?.favorite = false
        } else {
            movieFavorite?.favorite = true
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error \(error) when setting favorite for movie with id\(id)")
        }
    }
    
    func fetchFavoriteMovies() -> [MovieModel] {
        let coreDataStack = CoreDataStack()
        let managedContext = coreDataStack.persistentContainer.viewContext
        
        let request: NSFetchRequest<MovieModel> = MovieModel.fetchRequest()
        let predicate = NSPredicate(format: "favorite = %@", "true")
        request.predicate = predicate
        
        do {
            let results = try managedContext.fetch(request)
            return results
        } catch let error as NSError {
            print("Error \(error) when fetching favorite movies")
            return []
        }
    }
    
    func saveMovies(moviesForSave: [Movie]) {
        let coreDataStack = CoreDataStack()
        let managedContext = coreDataStack.persistentContainer.viewContext
        
        for movie in moviesForSave{
            let model = movieToModel(movie: movie, managedContext: managedContext)
            let check = fetchMovieById(id: movie.id)
            
            do {
                if (check == nil){
                    try managedContext.save()
                } else {
                    updateMovie(movieModel: model, movie: movie)
                    try managedContext.save()
                }
                print("Saved movies into database")
            } catch let error as NSError {
                print("Error \(error) when saving movies")
            }
        }
    }
    
    func movieToModel(movie: Movie, managedContext: NSManagedObjectContext) -> MovieModel {
        let model = MovieModel(context: managedContext)
        
        model.adult = movie.adult
        model.backdrop_path = movie.backdrop_path
        model.genre_ids = movie.genre_ids.map({Int64($0)})
        model.id = Int64(movie.id)
        model.original_language = movie.original_language
        model.original_title = movie.original_title
        model.overview = movie.overview
        model.popularity = movie.popularity
        model.poster_path = movie.poster_path
        model.release_date = movie.release_date
        model.title = movie.title
        model.video = movie.video
        model.vote_average = movie.vote_average
        model.vote_count = Int64(movie.vote_count)
        model.favorite = false
        
        return model
    }
    
    func genreToModel(genre: Genre, managedContext: NSManagedObjectContext) -> GenreModel{
        let model = GenreModel(context: managedContext)
        
        model.id = Int64(genre.id)
        model.name = genre.name
        
        return model
    }
    
    func fetchGenres() -> [GenreModel]{
        return []
    }
    
    func fetchGenreById(id: Int) -> GenreModel? {
        let coreDataStack = CoreDataStack()
        let managedContext = coreDataStack.persistentContainer.viewContext
        
        let request: NSFetchRequest<GenreModel> = GenreModel.fetchRequest()
        let predicate = NSPredicate(format: "id = %@", "\(id)")
        request.predicate = predicate
        request.fetchLimit = 1
        
        do {
            let results = try managedContext.fetch(request).first
            return results
        } catch let error as NSError {
            print("Error \(error) when fetching a movie with id \(id)")
            return nil
        }
    }
    
    func saveGenres(genres: [Genre]) {
        let coreDataStack = CoreDataStack()
        let managedContext = coreDataStack.persistentContainer.viewContext
        
        for genre in genres {
            let model = genreToModel(genre: genre, managedContext: managedContext)
            let check = fetchGenreById(id: genre.id)
            do {
                if (check == nil){
                    try managedContext.save()
                }
            } catch let error as NSError {
                print("Error \(error) when saving movies")
            }
        }
    }
    
    func updateMovie(movieModel: MovieModel?, movie: Movie) {
        movieModel?.adult = movie.adult
        movieModel?.backdrop_path = movie.backdrop_path
        movieModel?.genre_ids = movie.genre_ids.map({Int64($0)})
        movieModel?.id = Int64(movie.id)
        movieModel?.original_language = movie.original_language
        movieModel?.original_title = movie.original_title
        movieModel?.overview = movie.overview
        movieModel?.popularity = movie.popularity
        movieModel?.poster_path = movie.poster_path
        movieModel?.release_date = movie.release_date
        movieModel?.title = movie.title
        movieModel?.video = movie.video
        movieModel?.vote_average = movie.vote_average
        movieModel?.vote_count = Int64(movie.vote_count)
    }
    
}
