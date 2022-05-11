//import Foundation
//
//class FetchService {
//
//    static func fetchGroups() {
//
//    }
//
//    static func fetchGenres(){
//
//        let networkService = NetworkService()
//        var genres: [Genre]!
//
//        guard let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?language=en-US&api_key=08b9359132df1d9670e4d86391fbdc7e") else { return }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        print(request)
//
//        networkService.executeUrlRequest(request) { (result: Result<Genre, RequestError>) in
//            switch result {
//            case .failure(let error):
//                print(error)
//                return
//            case .success(let value):
//                print(value)
//            }
//
//        }
//
//    }
//
//    static func fetchMoviesForGroup(_ category: MovieCategory) {
//            let networkService = NetworkService()
//            guard let url = URL(string: "https://api.themoviedb.org/3") else {
//                return
//            }
//            var request = URLRequest(url: url)
//            request.httpMethod = "GET"
//
////            switch category {
////            case .popular:
////                request.setValue("/genre/movie/list", forHTTPHeaderField: "language=en-US&api_key=<api_key>")
////
////            case .trending:
////                <#code#>
////            case .topRated:
////                <#code#>
////            case .recommended:
////                <#code#>
////            }
//    }
//
//}
