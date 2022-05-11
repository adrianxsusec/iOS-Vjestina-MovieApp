import Foundation

class NetworkService: NetworkServiceProtocol {

    func executeUrlRequest<T: Decodable>(_ request: URLRequest, completionHandler: @escaping (Result<T, RequestError>) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, err in
            
            guard err == nil else {
                
                    completionHandler(.failure(.clientError))
                
                
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                      
                          completionHandler(.failure(.serverError))
                      
                          
                return
            }
            
            guard let data = data else {
                
                    completionHandler(.failure(.noData))
                
                return
            }
            
            print(data)
            
            guard let value = try? JSONDecoder().decode(T.self, from: data) else {
                
                    completionHandler(.failure(.dataDecodingError))
                    print("glup si")
                
                    
                
                return
            }
            
                completionHandler(.success(value))
            
        }
        
        dataTask.resume()
        
    }
    
}

enum RequestError: Error {
    case clientError
    case serverError
    case noData
    case dataDecodingError
}
