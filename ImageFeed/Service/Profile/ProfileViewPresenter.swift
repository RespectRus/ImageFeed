import UIKit

public protocol ProfileViewPresenterProtocol {
    var view: ProfileViewControllerProtocol? { get set }
    func viewDidLoad()
    func makeAlert() -> UIAlertController
}

final class ProfileViewPresenter: ProfileViewPresenterProtocol {
    
    weak var view: ProfileViewControllerProtocol?
    private let profileService = ProfileService.shared
    private var profileImageServiceObserver: NSObjectProtocol?
    
    func viewDidLoad() {
        profileImageServiceObserver = NotificationCenter.default
            .addObserver(
                forName: ProfileImageService.DidChangeNotification,
                object: nil,
                queue: .main
            ){ [weak self] _ in
                guard let self = self else {return}
                self.view?.updateAvatar()
            }
        view?.updateAvatar()
    }
    
    func makeAlert() -> UIAlertController {
        let alert = UIAlertController(
            title: "Пока, пока!",
            message: "Уверены, что хотите выйте?",
            preferredStyle: .alert
        )
        let canselAction = UIAlertAction(title: "Нет", style: .cancel)
        let confirnAction = UIAlertAction(title: "Да", style: .default) { [weak self] _ in
            guard let self = self else {return}
            self.view?.logout()
        }
        
        alert.addAction(canselAction)
        alert.addAction(confirnAction)
        
        return alert
    }
}
