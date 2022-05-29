import Foundation

class NetworkService: NetworkServiceProtocol {
    
    func executeUrlRequest<T: Decodable>(_ request: URLRequest, completionHandler: @escaping (Result<T, RequestError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, err in
            guard err == nil else {
                completionHandler(.failure(.clientError))
                return
            }
            
            guard
                let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode)
            else {
                completionHandler(.failure(.serverError))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.noData))
                return
            }
            
            guard let value = try? JSONDecoder().decode(T.self, from: data) else {
                completionHandler(.failure(.dataDecodingError))
                return
            }
            
            completionHandler(.success(value))
            
        }
        
        dataTask.resume()
        
    }
    
    func get<T: Decodable>(url: String, completionHandler: @escaping (Result<T, RequestError>) -> Void) {
        guard let url = URL(string: url_popular) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return executeUrlRequest(request, completionHandler: completionHandler)
    }
    
    func getTrending<T: Decodable>(url: String, completionHandler: @escaping (Result<T, RequestError>) -> Void) {
        guard let url = URL(string: url_trending) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return executeUrlRequest(request, completionHandler: completionHandler)
    }
    
    func getRecommended<T: Decodable>(url: String, completionHandler: @escaping (Result<T, RequestError>) -> Void) {
        guard let url = URL(string: url_recommended) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return executeUrlRequest(request, completionHandler: completionHandler)
    }
    
    func getTop<T: Decodable>(url: String, completionHandler: @escaping (Result<T, RequestError>) -> Void) {
        guard let url = URL(string: url_topRated) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return executeUrlRequest(request, completionHandler: completionHandler)
    }
    
}

enum RequestError: Error {
    case clientError
    case serverError
    case noData
    case dataDecodingError
}
