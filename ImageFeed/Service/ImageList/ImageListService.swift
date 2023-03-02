import UIKit

final class ImageListService {
    static let shared = ImageListService()
    private init() {}
    
    static let didChangeNotification = Notification.Name(rawValue: "ImageListServiceDidChange")
    static var lastLoadedPage: Int?
    
    private enum HttpMethods: String {
        case GET, POST, DELETE
    }
    
    private let urlSession = URLSession.shared
    
    private var task: URLSessionTask?
    private(set) var photos: [Photo] = []
    
    func fetchPhotosNextPage() {
        assert(Thread.isMainThread)
        task?.cancel()
        
        var nextPage: Int
        
        if let lastLoadedPage = ImageListService.lastLoadedPage {
            nextPage = lastLoadedPage + 1
            ImageListService.lastLoadedPage = nextPage
        } else {
            nextPage = 1
            ImageListService.lastLoadedPage = nextPage
        }
        
        guard let token = OAuth2TokenStorage().token else { return }
        let request = imageListRequest(numberPage: nextPage, token: token)
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<[PhotoResult], Error>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let photoResult):
                    photoResult.forEach { result in
                        let photo = self.getPhoto(from: result)
                        
                        if !self.photos.contains(photo) {
                            self.photos.append(photo)
                        }
                    }
                    NotificationCenter.default.post(
                        name: ImageListService.didChangeNotification,
                        object: self,
                        userInfo: ["photos" : self.photos])
                    self.task = nil
                case .failure(let error):
                    print(error)
                    self.task = nil
                }
            }
        }
        
        self.task = task
        task.resume()
    }
    
    private func imageListRequest(numberPage: Int, token: String) -> URLRequest {
        var request = URLRequest.makeHTTPRequest(
            path: "/photos" + "?page=\(numberPage)",
            httpMethod: HttpMethods.GET.rawValue,
            baseURL: Constants.defaultBaseURL)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    private func getPhoto(from result: PhotoResult) -> Photo {
        let imageSize = CGSize(width: CGFloat(result.width), height: CGFloat(result.height))
        
        var createdDate: Date?
        
        if let dateString = result.createdAt {
            createdDate = ISO8601DateFormatter().date(from: dateString)
        } else {
            createdDate = nil
        }
        
        let photo = Photo(id: result.id,
                          size: imageSize,
                          createdAt: createdDate,
                          welcomeDescription: result.description,
                          thumbImageURL: result.urls.thumb,
                          largeImageURL: result.urls.full,
                          isLiked: result.likedByUser)
        return photo
    }
    
}

extension ImageListService {
    func changeLIke(idPhoto: String, isLike: Bool, completion: @escaping (Result<Void, Error>) -> Void) {
        assert(Thread.isMainThread)
        task?.cancel()
        guard let token = OAuth2TokenStorage().token else { return }
        
        let httpMethod = isLike ? HttpMethods.POST.rawValue : HttpMethods.DELETE.rawValue
        let request = likeRequest(id: idPhoto, httpMethod: httpMethod, token: token)
        
        let task = urlSession.dataTask(with: request) { [weak self] _, response, error in
            if let error = error {
                print(error)
                completion(.failure(error))
                return
            }
            guard
                let response = response,
                let statusCode = (response as? HTTPURLResponse)?.statusCode,
                statusCode == 201 || statusCode == 200,
                let self = self else { return }
            
            self.changePhoto(photoId: idPhoto)
            completion(.success(Void()))
        }
        
        self.task = task
        task.resume()
    }
    
    private func likeRequest(id: String, httpMethod: String, token: String) -> URLRequest {
        var request = URLRequest.makeHTTPRequest(
            path: "/photos" + "/\(id)/like",
            httpMethod: httpMethod,
            baseURL: Constants.defaultBaseURL)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    private func changePhoto(photoId: String) {
        if let index = self.photos.firstIndex(where: { $0.id == photoId}) {
            let photo = self.photos[index]
            let newPhoto = Photo(id: photo.id,
                                 size: photo.size,
                                 createdAt: photo.createdAt,
                                 welcomeDescription: photo.welcomeDescription,
                                 thumbImageURL: photo.thumbImageURL,
                                 largeImageURL: photo.largeImageURL,
                                 isLiked: !photo.isLiked
            )
            
            self.photos[index] = newPhoto
        }
    }
}
