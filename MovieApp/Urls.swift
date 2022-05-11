import Foundation

let api_key = "08b9359132df1d9670e4d86391fbdc7e"

let url_popular = "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1&api_key=" + api_key
let url_trending = "https://api.themoviedb.org/3/trending/movie/week?api_key=" + api_key + "&page=1"
let url_topRated = "https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1&api_key=" + api_key
let url_recommended = "https://api.themoviedb.org/3/movie/103/recommendations?language=en-US&page=1&api_key=" + api_key

let url_genres = "https://api.themoviedb.org/3/genre/movie/list?language=en-US&api_key=" + api_key

func getMovieUrlById (_ id: Int) -> String {
    return "https://api.themoviedb.org/3/movie/" + String(describing: id) + "?language=en-US&page=1&api_key=" + api_key
}
