import Foundation

final class OAuthService {
    
    static let shared = OAuthService()
    private enum NetvorkError: Error {
        case codeError
    }
    
    func fetchOAuthToken(_ code: String, completion: @escaping (Result<String, Error>) -> Void) {
        var urlComponents = URLComponents(string: "https://unsplash.com/oauth/token")!
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: Constants.accessKey),
            URLQueryItem(name: "client_sekret", value: Constants.secretKey),
            URLQueryItem(name: "redirect_uri", value: Constants.redirectURI),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "grant_type", value: "authorization_code")
        ]
        let url = urlComponents.url!
        let request = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let response = response as? HTTPURLResponse,
               response.statusCode < 200 || response.statusCode >= 300 {
                completion(.failure(NetvorkError.codeError))
                return
            }
            
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(OAuthTokenResponseBody.self, from: data)
                    completion(.success(decodedData.accessToken))
                } catch let error {
                    completion(.failure(error))
                }
            } else {
                return
            }
        }
        task.resume()
    }
}

