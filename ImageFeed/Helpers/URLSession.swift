import UIKit

extension URLSession {
    
    private enum NetworkError: Error {
        case codeError
    }
    
    func objectTask<T: Decodable> (
        for request: URLRequest,
        completion: @escaping (Result<T, Error>) -> Void
    ) -> URLSessionTask {
        
        let task = dataTask(with: request, completionHandler: { (data, response, error) in
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                    return
                }
            }
            
            if let response = response as? HTTPURLResponse,
               response.statusCode < 200 || response.statusCode > 300 {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.codeError))
                    return
                }
            }
            
            guard let data = data else { return }
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedObject))
                }
            } catch let error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        })
        return task
    }
}
